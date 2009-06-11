#!perl -wT

use strict;

BEGIN {
  ($ENV{PWD}) = $ENV{PWD} =~ /(.*)/;
  require "$ENV{PWD}/test-lib/setup.pl";
}

use Test::More tests => 23;

# Ford and mercedes both implement Car::Interface and Car::Runnable. Fiat only
# implements Car::Interface.
#
# Mercedes has Car::German as a base class
#

# is the implementing class OK?

use_ok("Car::Ford");
my $ford = new Car::Ford;
ok( defined $ford, "Ford is instantiated" );

# Is it everything it should be?
isa_ok( $ford, "Car::Interface", "Car::Ford" );
isa_ok( $ford, "Car::Runnable", "Car::Ford" );
isa_ok( $ford, "Car::Ford", "Car::Ford" );

# type checking
ok( $ford->typeOf("Car::Interface"), "Implements the car interface" );
ok( $ford->typeOf("Car::Runnable"), "Extends the runnable" );

use_ok("Car::Fiat");
my $fiat = new Car::Fiat;
ok ( defined $fiat, "Fiat is instantiated" );

# Is it everything it should and shouldn't be?
isa_ok( $fiat, "Car::Interface", "Car::Fiat" );
ok( !$fiat->isa("Car::Runnable"), "Car::Fiat isnta Car::Runnable" );
isa_ok( $fiat, "Car::Fiat", "Car::Fiat" );

# type checking
ok( $fiat->typeOf("Car::Interface"), "Implements the car interface" );
ok( !$fiat->typeOf("Car::Runnable"), "Not extends the runnable" );

use_ok("Car::Mercedes");
my $merc = new Car::Mercedes;
ok ( defined $merc, "Mercedes ist instantiert, jah!" );

# Is it everything it should be?
isa_ok( $merc, "Car::Interface", "Car::Mercedes" );
isa_ok( $merc, "Car::Runnable", "Car::Mercedes" );
isa_ok( $merc, "Car::Mercedes", "Car::Mercedes" );
isa_ok( $merc, "Car::German", "Car::Mercedes");

# type checking
ok( $merc->typeOf("Car::Interface"), "Implements the car interface" );
ok( $merc->typeOf("Car::Runnable"), "Extends the runnable" );
ok( $merc->typeOf("Car::German"), "Extends germans" );

1;

