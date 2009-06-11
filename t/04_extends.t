#!perl -wT

use strict;

BEGIN {
  ($ENV{PWD}) = $ENV{PWD} =~ /(.*)/;
  require "$ENV{PWD}/test-lib/setup.pl";
}

use Test::More tests => 10;

# is the abstract in test-lib a true abstract?
use_ok("Car::Factory");
my $factory = new Car::Factory;
ok( defined $factory, "Factory has been instantiated");
isa_ok($factory, "Car::AbstractFactory", "Car::Factory");
isa_ok($factory, "Car::Factory", "Car::Factory");

ok( $factory->typeOf("Car::AbstractFactory"), "Spills own abstract" );

# has the implementation succ?
can_ok( "Car::Factory", "createCar" );

# does the impl. work?
my $car = $factory->createCar("ford");
isa_ok($car, "Car::Ford", "Factored car");
isa_ok($car, "Car::Runnable", "Factored car");

ok( $car->typeOf("Car::Runnable"), "Is a runnable car" );

can_ok($car, "run");



1;

