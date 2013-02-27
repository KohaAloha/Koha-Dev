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

use Smart::Comments '###';

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
       SELECT biblioitems.isbn, items.biblionumber, items.dateaccessioned, items.homebranch  from items join biblioitems ON  (biblioitems.biblionumber = items.biblionumber ) where biblioitems.isbn is not null   |;

        my @bind;
         if ($branch ){
            $q .= qq| and homebranch = ?| ;
            push @bind, $branch ;
        };

        $q .= qq|    ORDER BY dateaccessioned  DESC LIMIT 300 |;


#   C4::Context->dbh->trace(3 );
    my @recents =
      @{ C4::Context->dbh->selectall_arrayref( $q, { Slice => {} }, @bind ) };

   C4::Context->dbh->trace(0 );

    my ( $i ) = 0;
    my ( $bibs ) = 0;
    my ( $ol_fetches ) = 0;
    my @results;


    while ( $bibs <= 10 )  {
        $i++;
        my $rand_recnum=  int rand( scalar @recents);
        my $rec = $recents[ $rand_recnum ];



        last if scalar @recents == 0;

#        warn   scalar @recents;

        splice(@recents, $rand_recnum ,1);

        next unless $rec->{'isbn'};


        $rec->{'isbn'} =~ s/\|.*$//;
        $rec->{'isbn'} =~ s/^[ \t]+|[ \t]+$//g;

#        $rec->{'ii'} = $i;

        next unless length ($rec->{'isbn'})  > 8;



        # ---------------------------------
        # build string

        my $str =
          "http://covers.openlibrary.org/b/isbn/" . $rec->{'isbn'} . "-M.jpg";

#        warn $str;
        my ($URL_in) = $str;
        my $content = head($URL_in);

        $ol_fetches++;
        warn $ol_fetches;



        next unless ( $content->content_type eq "image/jpeg" );

        # ---------------------------------

        $rec->{img} = $str;

warn "$bibs, $rec->{'dateaccessioned'}, $rec->{'homebranch'}";


         my $hash_ref = grep {$_->{isbn}  ==  $rec->{'isbn'} } @results ;

        if ($hash_ref ) {
warn '----------------------------------------------------------';
            ### $hash_ref
            next ;
        }


        


        push @results, $rec;

p $rec;

#        my $search_for = $rand_bib;
#        my ($index) = grep { $rands[$_] eq $search_for } 0 .. $#rands;
#        splice( @rands, $index, 1 );
        $bibs++;

        #        my $marc_authors = GetMarcAuthors( $rec, 'MARC21' );
    }
p  @results;


    return \@results;
}

1;

__END__

=head1 AUTHOR

Koha Developement team <info@koha-community.org>

=cut
