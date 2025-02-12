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
                     topology
                     transport_and_format
                     status_codes
                     version_information_endpoint
                     credentials
                     mod_locations
                     mod_sessions
                     mod_cdrs
                     mod_tariffs
                     mod_tokens
                     mod_commands
                     mod_charging_profiles
                     mod_hub_client_info
                     mod_payments
                     types
                     changelog );

foreach my $file (@ocpi_parts) {
    if (open my $in, '<', $file.".asciidoc") {
        while (my $line = <$in>) {
            $line =~ s/copyright.asciidoc#//g;
            $line =~ s/version_history.asciidoc#//g;
            $line =~ s/introduction.asciidoc#//g;
            $line =~ s/terminology.asciidoc#//g;
            $line =~ s/topology.asciidoc#//g;
            $line =~ s/transport_and_format.asciidoc#//g;
            $line =~ s/status_codes.asciidoc#//g;
            $line =~ s/version_information_endpoint.asciidoc#//g;
            $line =~ s/credentials.asciidoc#//g;
            $line =~ s/mod_locations.asciidoc#//g;
            $line =~ s/mod_sessions.asciidoc#//g;
            $line =~ s/mod_cdrs.asciidoc#//g;
            $line =~ s/mod_tariffs.asciidoc#//g;
            $line =~ s/mod_tokens.asciidoc#//g;
            $line =~ s/mod_commands.asciidoc#//g;
            $line =~ s/mod_charging_profiles.asciidoc#//g;
            $line =~ s/mod_hub_client_info.asciidoc#//g;
            $line =~ s/mod_payments.asciidoc#//g;
            $line =~ s/types.asciidoc#//g;
            $line =~ s/changelog.asciidoc#//g;
            print $out $line;
        }
        close $in;
        print $out "\r\n\r\n<<<\r\n\r\n";
    } else {
        warn "Could not open '$file' for reading\n";
    }
}
close $out;
