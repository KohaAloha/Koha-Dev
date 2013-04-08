use Modern::Perl;
use Parse::DebControl;


use Data::Printer;
use Data::Dumper;

my $debug = 1;
        my $parser = new Parse::DebControl;

        $parser->DEBUG();


        my $data = $parser->parse_file('./debian/control', undef );



warn Dumper  @$data[0];
my $a =   @$data[0];

#warn $a->{'Build-Depends'};
#warn  $data;




warn Dumper  @$data[1];
