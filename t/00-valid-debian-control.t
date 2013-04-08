use Modern::Perl;
use Data::Printer;
use Data::Dumper;

use Parse::Deb::Control;

use Test::More;

plan tests => 1;


my $parser = Parse::Deb::Control->new('./debian/control');


p $parser;


 foreach my $para ($parser->get_paras('Package')) {
        print $para->{'Package'}, "\n";
    }


warn Dumper $parser->content;

1;
