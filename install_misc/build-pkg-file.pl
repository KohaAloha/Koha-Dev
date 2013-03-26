#!/usr/bin/perl

# Copyright (C) 2013 KohaAloha, NZ
#
# This file is part of Koha.
#
# Koha is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 3 of the License, or (at your option) any later
# version.
#
# Koha is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Koha; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

=pod
a script to build the ./install_misc/debian.packages file from ./debian.control

script must be run with --force arg, to execute

=cut

use Modern::Perl;
use Data::Printer;
use Data::Dumper;

use Parse::Deb::Control;

use Getopt::Long;
my $force,;
my $result = GetOptions(
    'f|force' => \$force,

);

if ( not $force ) {
    print_usage();
    exit 0;
}

my $parser = Parse::Deb::Control->new('./debian/control');

my $header = <<EOF;
#  WARNING! This file is manually generated from executing
#  the './install_misc/build-pkg-file.pl script
#
#  Do not manually edit this file - you risk losing your changes
EOF

my $para;

foreach my $entry ( $parser->get_keys('Package') ) {
    my $r = ${ $entry->{'value'} };
    $para = $entry if $r =~ m/koha-common/;
}

my $source;
foreach my $entry ( $parser->get_keys('Source') ) {
    my $r = ${ $entry->{'value'} };
    $source = $entry if $r =~ m/koha/;
}

my $dep  = $para->{'para'}->{'Depends'};
my $bdep = $source->{'para'}->{'Build-Depends'};
my $deps = $dep . $bdep;

my @deps2;
push @deps2, $header;

foreach my $d ( split '\n', $deps ) {
    next if $d =~ qr/\$/;

    $d =~ s/,//;
    $d =~ s/.//;
    $d =~ s/^[ \t]+|[ \t]+$//g;
    $d =~ s/\s.*$//;

    $d =~ s/$/ install/;
    $d .= "\n";

    push @deps2, $d if $d !~ /\$/;
}

my $file = './install_misc/debian.packages';
open( my $fh, '>', $file );

print $fh (@deps2);
close $fh;

sub print_usage {
    print <<_USAGE_;
a script to build the ./install_misc/debian.packages file from ./debian.control

script must be run with --force arg, to execute

Parameters:
    --force or -f           run this script
_USAGE_
}

1;
