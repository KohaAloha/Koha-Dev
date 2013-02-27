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

use Data::Printer;

#use Smart::Comments '###';

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

use LWP::Simple;

sub GetNewBiblios {
    my $branch = shift();

    my $q = qq|
       SELECT biblioitems.isbn, items.biblionumber  from items join biblioitems ON  (biblioitems.biblionumber = items.biblionumber ) where biblioitems.isbn is not null   |;

        my @bind;
         if ($branch ){
            $q .= qq| and homebranch = ?| ;
            push @bind, $branch ;
        };

        $q .= qq|    ORDER BY dateaccessioned  DESC LIMIT 100 |;


#   C4::Context->dbh->trace(3 );
    my @recents =
      @{ C4::Context->dbh->selectall_arrayref( $q, { Slice => {} }, @bind ) };

   C4::Context->dbh->trace(0 );

    my ( $i ) = 0;
    my ( $bibs ) = 0;
    my @results;


    while ( 1 )  {
        $i++;
        my $rec = $recents[ int rand( scalar @recents) ];
p $rec;



#exit;
#p $recents[$rand_bib];



#        my $row = GetBiblioData($rand_bib);
#        my $rec = GetMarcBiblio($rand_bib);


#        warn  $row->{'isbn'};


        next unless $rec->{'isbn'};

        # ---------------------------------
        # build string

        my $str =
          "http://covers.openlibrary.org/b/isbn/" . $rec->{'isbn'} . "-M.jpg";

#        warn $str;
        my ($URL_in) = $str;
        my $content = head($URL_in);
        next unless ( $content->content_type eq "image/jpeg" );

        # ---------------------------------

        $rec->{img} = $str;
### $row

        push @results, $rec;

#        my $search_for = $rand_bib;
#        my ($index) = grep { $rands[$_] eq $search_for } 0 .. $#rands;
#        splice( @rands, $index, 1 );
        $bibs++;

        #        my $marc_authors = GetMarcAuthors( $rec, 'MARC21' );
    }

    return \@results;
}

1;

__END__

=head1 AUTHOR

Koha Developement team <info@koha-community.org>

=cut
