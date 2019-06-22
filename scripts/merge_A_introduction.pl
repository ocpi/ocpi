#!/usr/bin/perl
use strict;
use warnings;

# merge all files to 1 asciidoc file.
my $merged_file = 'ocpi_merged.adoc';

open my $out, '>', $merged_file or die "Could not open '$merged_file' for appending\n"; 

my @ocpi_parts = qw( pdf_layout
                     copyright
                     version_history
                     introduction
                     terminology
                     architecture
                     topology
                     security
                     privacy
                     data_retention
                     swagger);
              
foreach my $file (@ocpi_parts) {
    if (open my $in, '<', $file.".asciidoc") {
        while (my $line = <$in>) {
            $line =~ s/copyright.asciidoc#//g;
            $line =~ s/version_history.asciidoc#//g;
            $line =~ s/introduction.asciidoc#//g;
            $line =~ s/terminology.asciidoc#//g;
            $line =~ s/architecture.asciidoc#//g;
            $line =~ s/topology.asciidoc#//g;
            $line =~ s/security.asciidoc#//g;
            $line =~ s/privacy.asciidoc#//g;
            $line =~ s/data_retention.asciidoc#//g;
            $line =~ s/swagger.asciidoc#//g;
            print $out $line;
        }
        close $in;
        print $out "\r\n\r\n<<<\r\n\r\n";
    } else {
        warn "Could not open '$file' for reading\n";
    }
}
close $out;