package C4::Carousel;

# Copyright 2013 CALYX
#
# This file is part of Koha.
#
# Koha is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# Koha is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# Koha; if not, write to the Free Software Foundation, Inc., 59 Temple Place,
# Suite 330, Boston, MA  02111-1307 USA

use strict;
use warnings;

# use utf8;
# Force MARC::File::XML to use LibXML SAX Parser
#$XML::SAX::ParserPackage = "XML::LibXML::SAX";

use C4::Koha;
use C4::Biblio;
use C4::Dates qw/format_date/;
use C4::External::Amazon;

#use Smart::Comments '####';

use vars qw($VERSION @ISA @EXPORT);

BEGIN {
    $VERSION = 1.00;

    require Exporter;
    @ISA = qw( Exporter );

    push @EXPORT, qw(
      &GetNewBiblios
    );
}

=head1 NAME

C4::Carousel

=head1 DESCRIPTION

=cut

sub GetNewBiblios {

    my $q = qq|
       SELECT biblio.biblionumber FROM biblioitems
        JOIN biblio ON (biblio.biblionumber = biblioitems.biblionumber )
        WHERE isbn IS NOT NULL 
        ORDER BY datecreated LIMIT 200 |;

    my @recents =
      @{ C4::Context->dbh->selectall_arrayref( $q, { Slice => {} } ) };
    my @rands;
    foreach my $recent (@recents) {
        push @rands, $recent->{biblionumber};
    }

    my ( $i, $j ) = 0;
    my $i = 0;
    my @results;

    #    while ( $i < 5 and $j < 10) {
    while ( $i < 10 and $j < 5 ) {
        my $rand_bib = $rands[ int rand($#rands) ];

        my $row = GetBiblioData($rand_bib);
        my $rec = GetMarcBiblio($rand_bib);

        #my  $aws  = [ 'Large', 'Similarities' ];
        my $aws = ['Large'];

        my $amazon_details =
          get_amazon_details( $row->{'isbn'}, $rec, 'MARC21', $aws );

        my $img;
        if ($amazon_details) {

            my $title = $row->{'title'};
            eval {
                $img =
                  $amazon_details->{Items}->{Item}[0]->{'ImageSets'}
                  ->{'ImageSet'}->{'MediumImage'}->{'URL'};
            };
            next if $@;

    #            $img =~ s/\.jpg/PC_PU3_\.jpg/;    # add rotate, and back-shadow
            $img =~ s/\.jpg/PC_\.jpg/;    # add rotate, and back-shadow
            #### $img
        }

        $j++ if !$amazon_details;

        #       $img = "/opac-tmpl/prog/images/no-cover.png" unless $img;
        next unless $img;

        $row->{img} = $img;
        push @results, $row;

        my $search_for = $rand_bib;
        my ($index) = grep { $rands[$_] eq $search_for } 0 .. $#rands;
        splice( @rands, $index, 1 );
        $i++;

        #        my $marc_authors = GetMarcAuthors( $rec, 'MARC21' );
    }

    return \@results;
}

1;

__END__

=head1 AUTHOR

Koha Developement team <info@koha-community.org>

=cut
