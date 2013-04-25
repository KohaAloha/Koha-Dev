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
a script to build a file containing a list of debian packages needed to install Koha - from ./debian.control

script must be run with --run arg, to execute

=cut

use Modern::Perl;
use List::MoreUtils qw(uniq);
use Parse::DebControl;

use Getopt::Long;
my $run,;
my $result = GetOptions( 'r|run' => \$run, );

if ( not $run ) {
    print_usage();
    exit 0;
}

my $parser = new Parse::DebControl;
$parser->DEBUG();

my %opt = ( 'stripComments' => 1, );
my $data = $parser->parse_file( './debian/control', \%opt );

my $deps;
foreach my $p (@$data) {
    $deps .= $p->{'Depends'} . "\n" if $p->{'Depends'};
}

my @deps2;

foreach my $d ( split '\n', $deps ) {

    next if $d =~ qr/^\$/;

    $d =~ s/\|.*$//;
    $d =~ s/,//;
    $d =~ s/\"//;
    $d =~ s/^[ \t]+|[ \t]+$//g;
    $d .= "\n";

    push @deps2, $d;
}

my @uniq = uniq(@deps2);
print @uniq;

sub print_usage {
    print <<'_USAGE_';

this script outputs a list of debian packages for Koha, built from the ./debian.control file

so, something like...
 $ ./koha-debian-deps.pl -r > install_misc/debian.packages

then...
 $  aptitude install $( < install_misc/debian.packages)

or...
 $  apt-get install  $( < install_misc/debian.packages)


script must be run with --run arg, to execute

Parameters:
    --run or -r           run this script
_USAGE_

}

1;
