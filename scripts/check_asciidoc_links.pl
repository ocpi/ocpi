#!/usr/bin/perl
use strict;
use warnings;
use Class::Struct;
use File::Basename;

struct Bookmark => {
    name    => '$',
    linenr  => '$',
};

struct Reference => {
    target   => '$',
    caption  => '$',
    linenr   => '$',
	bookmark => '$',
};


my $file           = "";
my $bookmarksfile  = "bookmarks.txt";
my $referencesfile = "references.txt";
my $path = "";

main();

sub main{
	my $argc = @ARGV;
	if ($argc == 0)
	{
		print "Usage: perl check_asciidoc_links.pl <inputfile>\n";
		print "--------------------------------------------------\n";
		print "inputfile: asciidoc input, usually a .adoc file.\n";
		exit;
	}
	if ($argc > 0)
	{
		$file = $ARGV[0];
		$path = dirname($file);
		$bookmarksfile  = ">".($path)."bookmarks.txt";
		$referencesfile = ">".($path)."references.txt";
	}
	print "================================================================================\n";
	print "Tool      : check_asciidoc_links 0.11\n";
	print "Author    : Robert de Leeuw\n";
	print "--------------------------------------------------------------------------------\n";
	print "Input     : $file\n";
	print "Bookmarks : $bookmarksfile\n";
	print "References: $referencesfile\n";
	print "================================================================================\n\n";

	open(FD, $file);
	my @lines = <FD>;
	close FD;
	
	my @bookmarks  = get_bookmarks(\@lines);
	my @references = get_references(\@lines);

	match_references(\@references, \@bookmarks);
}



#================================================================================
#= Matching functions                                                           =
#================================================================================
sub cleanup($)
{
	my $s = shift;

	$s =~ s/^[_ \t]*//;
	$s =~ s/[_ \t]*$//;
	$s = lc($s);
	
	return $s;
}

sub better_match($$$$)
{
	my $linenr = shift;
	my $match  = shift;
	my $bnew   = shift;
	my $borg   = shift;
	
	if ($borg)
	{
		my ($n, $o) = (cleanup($bnew->name), cleanup($borg->name));
		$match = cleanup($match);
		
		#first try a litteral match
		if ($match eq $o)
		{
			print ">>> match:".($match)."\n";
			print ">>> old  : $o\n";
			print ">>> new  : $n\n";

			print "old\n"; return (1, $borg); 
		}
		
		if ($match eq $n) 
		{
			print "Better match $match on $n than $o (line $linenr)\n";
			return (0, $bnew); 
		}
	}
	
	return (0, $bnew);
}


sub match_bookmark($$$$)
{
	my $matches = shift;
	my $ref     = shift;
	my $search  = shift;
	my $bookmark= shift;
	my $exists  = 0;
	my $bm;
	
	if ($ref->caption =~ m/$search/)
	{
		($exists, $bm) = better_match($ref->linenr, $ref->caption, $bookmark, $ref->bookmark);
		$matches = ($matches == 0) ? 1 : $matches + $exists;
		$ref->bookmark($bm);
	}
	
	if (($matches<=0) && ($ref->target =~ m/$search/))
	{
		($exists, $bm) = better_match($ref->linenr, $ref->target, $bookmark, $ref->bookmark);
		$matches = ($matches == 0) ? 1 : $matches + $exists;
		$ref->bookmark($bm);
	}
	
	return $matches;
}


sub match_references(\[$@]\[$@]){
	my $refref = shift;
	my $bmref  = shift;
	my @references = @{$refref};
	my @bookmarks  = @{$bmref};
	my $reference;
	my $bookmark;
	my $search;
	my $matches;
	my $count;
	
	foreach $reference (@references)
	{
		$matches = 0;
		
		if ($reference->target)
		{
			foreach $bookmark (@bookmarks)
			{
				$search = "\^[_]?".$bookmark->name."[_]?\$";
				$search =~ s/ /-/g;
				$matches = match_bookmark($matches, $reference, $search, $bookmark);
			}
		}

		if ($matches>1) { print "ERROR: too many matches ($matches) for ".($reference->target)."\n"; }
	}

	print "================================================================================\n\n";
	$count = 0;
	foreach $reference (@references)
	{
		if ($reference->bookmark)
		{
			$count++;
		}
		else
		{
			print "Not found: linenr : ".($reference->linenr)."\n";
			print "           target : ".($reference->target)."\n";
			print "           caption: ".($reference->caption)."\n";
		}
	}
	
	print "$count matches, ".(scalar @references - $count). " unmatched\n";
	if ((scalar @references - $count) > 0)
	{
		exit((scalar @references - $count));
	}
    print "\n";
}



#================================================================================
#= Parse Bookmark functions                                                     =
#================================================================================
sub get_bookmarks(\[$@]){
	my $ref = shift;
	my @lines = @{$ref};
	my @bookmarks = ();
	my $bookmark;
	my $line;
	my $linenr = 0;
	my $name;
	my $prevbookmarkname = "";
	my $count = 0;
	
	print "Gathering bookmarks\n";
	
	foreach $line (@lines)
	{
		$linenr++;
		
		if ($line =~ m/\[\[.*\]\]/)
		{
			($name) = $line =~ m/\[\[(.*)\]\]/;
			$bookmark = Bookmark->new();
			$bookmark->name($name);
			$bookmark->linenr($linenr);
			push(@bookmarks, $bookmark);
		}
	}

	open BFF, $bookmarksfile;
	foreach $bookmark (sort {$a->name cmp $b->name} @bookmarks)
	{
		print BFF ($bookmark->name).",".($bookmark->linenr)."\n";
		if ($prevbookmarkname eq ($bookmark->name))	
		{
			print "Duplicate bookmark: ".($bookmark->name)." (line: ".($bookmark->linenr).")\n";
			$count++;
		}
		$prevbookmarkname = $bookmark->name;
	}
	close BFF;

	print "Duplicate bookmarks found: ".$count."\n";
	if ($count > 0)
	{
		exit($count);
	}
	
	return @bookmarks;
}


#================================================================================
#= Parse Reference functions                                                    =
#================================================================================
sub get_references(\[$@]){
	my $ref = shift;
	my @lines = @{$ref};
	my @references = ();
	my $reference;
	my $line;
	my ($linenr, $retries) = (0);
	my $target;
	my $caption;
	my $found;

	print "Gathering references\n";
	
	foreach $line (@lines)
	{
		$linenr++;
		$retries = 0;
RETRY:
		$target  = "";
		$caption = "";
		$found   = 0;
		
		#Check for <<,>> format
        while($line =~ m/<<([^,]*),([^>]*)>>/g){
            $target = $1;
            $caption = $2;
            if ($caption) {chomp $caption;}
            if ($target)  {chomp $target; }
            if ($target && $caption)
            {
                $reference = Reference->new();
                $reference->target($target);
                $reference->caption($caption);
                $reference->linenr($linenr);
                push(@references, $reference);
            }
        }

        #check for <<>> without caption.
		while ($line =~ m/<<([^,]*)>>/g)
		{
		    $target = $1;
			$caption = "#### no caption given ####";
		    if ($caption) {chomp $caption;}
            if ($target)  {chomp $target; }
            if ($target && $caption)
            {
                $reference = Reference->new();
                $reference->target($target);
                $reference->caption($caption);
                $reference->linenr($linenr);
                push(@references, $reference);
            }
		}

		#Check for link: format
		while ($line =~ m/link\:[\#]?([^\[]*)\[([^\]]*)\].*/g)
		{
		    $target = $1;
            $caption = $2;
			if ($caption) {chomp $caption;}
            if ($target)  {chomp $target; }
            if ($target && $caption)
            {
                $reference = Reference->new();
                $reference->target($target);
                $reference->caption($caption);
                $reference->linenr($linenr);
                push(@references, $reference);
            }
		}
	}

	open RFF, $referencesfile;
	foreach $reference (sort {$a->target cmp $b->target} @references)
	{
		print RFF ($reference->target).",\"".($reference->caption)."\",".($reference->linenr)."\n";
	}
	close RFF;
	
	return @references;
}
