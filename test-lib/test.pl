#!/usr/bin/perl -l

use strict;

BEGIN {
  unshift @INC, "./lib", "./test-lib";
}

use Car::Factory;

my $factory = new Car::Factory;

foreach my $model ( qw(fiat ford mercedes) ) {

  print "-- " . uc($model) . ":";
  my $car = $factory->createCar($model);

  print "The car isa : " . join(", ", $car->typeOf);

  print "The $car car " . ( $car->can("implements") ? "can" : "cant" ) . " tell what it implements";

  $car->openDoors & $car->closeDoors;
  $car->start;

  if ( $car->typeOf("Car::Runnable") ) {
    local $\ = "";
    print ("-- we can run the car!\n  ") & $car->run;
    print "\n\n";
  }

  $car->stop;

  $car->openDoors & $car->closeDoors;
  print "\n";
}

if ( $factory->isa("Car::AFactory") ) {
  print join(", ", @{$factory->createdCars});
}

