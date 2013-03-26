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

script must be run with -f/--force arg, to execute

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
    my $ss = ${ $entry->{'value'} };
    $para = $entry if $ss =~ m/koha-common/;
}

my $source;
foreach my $entry ( $parser->get_keys('Source') ) {
    my $ss = ${ $entry->{'value'} };
    $source = $entry if $ss =~ m/koha/;
}

my $dep  = $para->{'para'}->{'Depends'};
my $bdep = $source->{'para'}->{'Build-Depends'};
my $a    = $dep . $bdep;

my @moo;
push @moo, $header;

foreach my $aa ( split '\n', $a ) {
    next if $aa =~ qr/\$/;

    $aa =~ s/,//;
    $aa =~ s/.//;
    $aa =~ s/^[ \t]+|[ \t]+$//g;
    $aa =~ s/\s.*$//;

    $aa =~ s/$/ install/;
    $aa .= "\n";

    push @moo, $aa if $aa !~ /\$/;
}

my $file = './install_misc/debian.packages';
open( my $fh, '>', $file );

print $fh (@moo);
close $fh;

sub print_usage {
    print <<_USAGE_;
a script to build the ./install_misc/debian.packages file from ./debian.control

script must be run with -f/--force arg, to execute

Parameters:
    --force or -f           run this script
_USAGE_
}

1;
