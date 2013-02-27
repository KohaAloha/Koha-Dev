package C4::ItemType;

# Copyright Liblime 2009
# Parts Copyright Tamil 2011
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
# You should have received a copy of the GNU General Public License along
# with Koha; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use strict;
use warnings;
use C4::Context;

our $AUTOLOAD;




=head1 NAME

C4::ItemType - objects from the itemtypes table

=head1 SYNOPSIS

    use C4::ItemType;
    my @itemtypes = C4::ItemType->all;
    print join("\n", map { $_->description } @itemtypes), "\n";

=head1 DESCRIPTION

Objects of this class represent a row in the C<itemtypes> table.

Currently, the bare minimum for using this as a read-only data source has
been implemented.  The API was designed to make it easy to transition to
an ORM later on.

=head1 API

=head2 Class Methods

=cut

=head3 C4::ItemType->new(\%opts)

Given a hashref, a new (in-memory) C4::ItemType object will be instantiated.
The database is not touched.

=cut

sub new {
    my ($class, $opts) = @_;
    bless $opts => $class;
}




=head3 C4::ItemType->all

This returns all the itemtypes as objects.  By default they're ordered by
C<description>.

=cut

sub all {
    my ($class) = @_;
    my $dbh = C4::Context->dbh;

    my @itypes;
    for ( @{$dbh->selectall_arrayref(
        "SELECT * FROM itemtypes ORDER BY description", { Slice => {} })} )
    {
        utf8::encode($_->{description});
        push @itypes, $class->new($_);
    }
    return @itypes;
}




=head2 Object Methods

These are read-only accessors for attributes of a C4::ItemType object.

=head3 $itemtype->itemtype

=cut

=head3 $itemtype->description

=cut

=head3 $itemtype->renewalsallowed

=cut

=head3 $itemtype->rentalcharge

=cut

=head3 $itemtype->notforloan

=cut

=head3 $itemtype->imageurl

=cut

=head3 $itemtype->summary

=cut

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*://;
    if (exists $self->{$attr}) {
        return $self->{$attr};
    } else {
        return undef;
    }
}

sub DESTROY { }



# ack itemtypes | grep '\.pm' | awk '{ print $1 }' | sed 's/:.*$//' | sort | uniq | sed -e 's,/,::,g' -e 's/\.pm//' -e 's/^/L<C4::/' -e 's/$/>,/'

=head1 SEE ALSO

The following modules make reference to the C<itemtypes> table.

L<C4::Biblio>,
L<C4::Circulation>,
L<C4::Context>,
L<C4::Items>,
L<C4::Koha>,
L<C4::Labels>,
L<C4::Overdues>,
L<C4::Reserves>,
L<C4::Search>,
L<C4::VirtualShelves::Page>,
L<C4::VirtualShelves>,
L<C4::XSLT>



=head1 AUTHOR

John Beppu <john.beppu@liblime.com>

=cut

1;
