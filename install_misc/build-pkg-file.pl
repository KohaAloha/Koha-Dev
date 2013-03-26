use Modern::Perl;
use Data::Printer;
use Data::Dumper;

use Parse::Deb::Control;

my $parser = Parse::Deb::Control->new('./debian/control');

my $header = qq|
################################################################
#  WARNING! This file is manually generated from executing 
#  the './install_misc/build-pkg-file.pl script
#
#  Do not manually edit this file - you risk losing your changes
################################################################
|;

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

1;
