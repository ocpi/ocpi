#!/usr/bin/perl
use strict;
use warnings;

# merge all files to 1 asciidoc file.
my $merged_file = 'ocpi_merged.adoc';

open my $out, '>', $merged_file or die "Could not open '$merged_file' for appending\n"; 

my @ocpi_parts = qw( pdf_layout
                     copyright
                     version_history
                     introduction);
              
foreach my $file (@ocpi_parts) {
    if (open my $in, '<', $file.".asciidoc") {
        while (my $line = <$in>) {
            $line =~ s/copyright.asciidoc#//g;
            $line =~ s/version_history.asciidoc#//g;
            $line =~ s/introduction.asciidoc#//g;
            print $out $line;
        }
        close $in;
        print $out "\r\n\r\n<<<\r\n\r\n";
    } else {
        warn "Could not open '$file' for reading\n";
    }
}
close $out;