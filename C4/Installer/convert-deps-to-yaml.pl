package C4::Installer::PerlDependencies;

use warnings;
use strict;

use YAML qw(Dump Bless);

require "C4/Installer/PerlDependencies.pm";

our $PERL_DEPS;

print Dump $PERL_DEPS;

1;

