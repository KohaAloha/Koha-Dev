package C4::Linker::LastMatch;

# Copyright 2011 C & P Bibliography Services
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
use Carp;
use C4::Heading;
use C4::Linker::Default;    # Use Default for flipping

use base qw(C4::Linker);

sub new {
    my $class = shift;
    my $param = shift;

    my $self = $class->SUPER::new($param);
    $self->{'default_linker'} = C4::Linker::Default->new($param);
    bless $self, $class;
    return $self;
}

sub get_link {
    my $self    = shift;
    my $heading = shift;
    return $self->{'default_linker'}->get_link( $heading, 'last' );
}

sub flip_heading {
    my $self    = shift;
    my $heading = shift;

    return $self->{'default_linker'}->flip($heading);
}

1;
__END__

=head1 NAME

C4::Linker::LastMatch - match against the last authority record

=cut
