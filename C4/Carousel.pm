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

    $q .= qq|    ORDER BY dateaccessioned  DESC LIMIT 200 |;

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

    use Cache::Memcached;

    my $cache = new Cache::Memcached { 'servers' => ["127.0.0.1:11211"] };

    my $ua = LWP::UserAgent->new;
    $ua->env_proxy;    # initialize from environment variables
    $ua->proxy( http => 'http://miso:3128' );

    my $total = 0;

    my $tt0 = [gettimeofday];
    while ( $bibs < 3 ) {
        $i++;

        warn "$i, $ol_fetches, $bibs";

        my $rand_recnum = int rand( scalar @recents );
        my $rec         = $recents[$rand_recnum];

        last if scalar @recents == 0;

        last if $i > 200;    # just for safety

        #        warn   scalar @recents;

        splice( @recents, $rand_recnum, 1 );

        next unless $rec->{'isbn'};

        $rec->{'isbn'} =~ s/\|.*$//;
        $rec->{'isbn'} =~ s/^[ \t]+|[ \t]+$//g;

        #        $rec->{'ii'} = $i;

        next unless length( $rec->{'isbn'} ) > 8;


    #    my $hash_ref = grep { $_->{isbn} eq $rec->{'isbn'} } @results;
    #    if ($hash_ref) {
    #        next;
    #    }




        # -------------

        # check store

        my $image_url = $cache->get( $rec->{'isbn'} );

        my ( $t0, $t1, $str, $req, $res, $elapsed, $headers );

        #            my $content = $res->content;

        $t1 = [gettimeofday];
        $elapsed = tv_interval( $t0, $t1 );

        #      warn $elapsed;
        $total += $elapsed;

        unless ($image_url) {
            $t0 = [gettimeofday];

            $image_url =
                "http://covers.openlibrary.org/b/isbn/"
              . $rec->{'isbn'}
              . "-M.jpg";

            $req     = HTTP::Request->new( 'GET', $image_url );
            $res     = $ua->request($req);
            $headers = $res->headers;

            warn $headers->{'x-cache'};

            $ol_fetches++;

        }

        # ---------------------------------

        #        warn "$bibs, $rec->{'dateaccessioned'}, $rec->{'homebranch'}";


        # ---------------------------------
        unless ( $headers->{'x-cache'} =~ /^HIT/ ) {

            warn "add miss to cache -  $rec->{'isbn'}";

            $cache->set( $rec->{'isbn'}, 0 );
            next;
        }
        else {

            warn "add HIT to cache -  $rec->{'isbn'}  $image_url ";

            $cache->set( $rec->{'isbn'}, $image_url  );

        }

        # ---------------------------------






        my $row = GetBiblioData( $rec->{biblionumber} );

        $rec->{image_url} = $image_url ? $image_url : $str;
        $rec->{title}     = $row->{title};
        $rec->{author}    = $row->{author};

#        $cache->set( $rec->{'isbn'}, $rec->{image_url} );

        push @results, $rec;

        $bibs++;
    }

    my $tt1 = [gettimeofday];

    #        warn  tv_interval( $tt0, $tt1 );

    #    p @results;

    #    $cache->set( 999 ,  'zzz' );
    return \@results;
}

1;

__END__

=head1 AUTHOR

Koha Developement team <info@koha-community.org>

=cut
