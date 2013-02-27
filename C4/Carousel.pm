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

use Time::HiRes qw/gettimeofday tv_interval/;

sub GetNewBiblios {
    my $branch = shift();

    my $q = qq|
       SELECT biblioitems.isbn, items.biblionumber, items.dateaccessioned, items.homebranch  from items join biblioitems ON  (biblioitems.biblionumber = items.biblionumber ) where biblioitems.isbn is not null   |;

    my @bind;
    if ($branch) {
        $q .= qq| and homebranch = ?|;
        push @bind, $branch;
    }

    $q .= qq|    ORDER BY dateaccessioned  DESC LIMIT 300 |;

    #   C4::Context->dbh->trace(3 );
    my @recents =
      @{ C4::Context->dbh->selectall_arrayref( $q, { Slice => {} }, @bind ) };

    C4::Context->dbh->trace(0);

    my ($i)          = 0;
    my ($bibs)       = 0;
    my ($ol_fetches) = 0;
    my @results;

    use LWP::Simple;
    use LWP::UserAgent;
    my $ua = LWP::UserAgent->new;
    $ua->env_proxy;    # initialize from environment variables
    $ua->proxy( http => 'http://miso:3128' );

    my $total = 0;  

        my $tt0 = [gettimeofday];
    while ( $bibs <= 10 ) {
        $i++;
        warn "$i, $ol_fetches, $bibs";




        my $rand_recnum = int rand( scalar @recents );
        my $rec         = $recents[$rand_recnum];

        last if scalar @recents == 0;

              last if $i > 50 ;

        #        warn   scalar @recents;

        splice( @recents, $rand_recnum, 1 );

        next unless $rec->{'isbn'};

        $rec->{'isbn'} =~ s/\|.*$//;
        $rec->{'isbn'} =~ s/^[ \t]+|[ \t]+$//g;

        #        $rec->{'ii'} = $i;

        next unless length( $rec->{'isbn'} ) > 8;

        # ---------------------------------
        # build string


        my $t0 = [gettimeofday];

        my $str =
          "http://covers.openlibrary.org/b/isbn/" . $rec->{'isbn'} . "-M.jpg";

        my $req     = HTTP::Request->new( 'GET', $str );
        my $res     = $ua->request($req);
        my $headers = $res->headers;





        next unless $headers->{'x-cache'} =~ /^HIT/;

        my $content = $res->content;

        my $t1 = [gettimeofday];

        my $elapsed = tv_interval( $t0, $t1 );
        warn $elapsed;
        $total += $elapsed;

        $ol_fetches++;

      #  next unless $content;

        # ---------------------------------

        $rec->{img} = $str;

#        warn "$bibs, $rec->{'dateaccessioned'}, $rec->{'homebranch'}";

        my $hash_ref = grep { $_->{isbn} eq  $rec->{'isbn'} } @results;

        if ($hash_ref) {
            warn '----------------------------------------------------------';
            ### $hash_ref
            next;
        }

        push @results, $rec;

        $bibs++;
    }

        my $tt1 = [gettimeofday];
        warn  tv_interval( $tt0, $tt1 );
    return \@results;
}

1;

__END__

=head1 AUTHOR

Koha Developement team <info@koha-community.org>

=cut
