#!/usr/bin/perl
# Author  : Quincy Bowers
# Contact : xanthmode@gmail.com
################################################################################
# DESCRIPTION 
################################################################################
#
# Calculates Weight Watchers POINTS values.
#
################################################################################

use strict;
use warnings;

my ( $calories, $fiber, $fat, $points );

if ( grep /^-h/, @ARGV )
{
    while ( <DATA> )
    {
        print;
    }
    exit 0;
}

( $calories, $fiber, $fat ) = @ARGV;

if ( ! $calories )
{
    print "Calories : ";
    $calories = <STDIN>;
    chomp $calories;
}
else
{
    print "Calories : $calories\n";
}

if ( ! $fiber )
{
    print "Fiber    : ";
    $fiber = <STDIN>;
    chomp $fiber;
    
    if ( $fiber > 4 )
    {
        $fiber = 4;
    }
}
else
{
    if ( $fiber > 4 )
    {
        $fiber = 4;
    }
    
    print "Fiber    : $fiber\n";
}

if ( ! $fat )
{
    print "Fat      : ";
    $fat = <STDIN>;
    chomp $fat;
}
else
{
    print "Fat      : $fat\n";
}

### The POINTS formula.
$points = int( ( $calories / 50 ) + ( $fat / 12 ) - ( $fiber / 5 ) );

print "\nThe POINTS formula\n";
print "( CALORIES / 50 ) + ( FAT / 12 ) - ( FIBER / 5 ) = POINTS\n";
printf "( %8s / 50 ) + ( %3s / 12 ) - ( %5s / 5 ) = %s\n\n", $calories, $fat, $fiber, $points;
print "One serving is equal to $points POINTS.\n";


__END__
HELP SCREEN

USAGE

$ points.pl [calories] [fiber] [fat]

calories    Number of calories per serving.
fiber       Amount of fiber per serving in grams.
fat         Amount of fat per serving in grams.

If you call points.pl with no arguments or partial
arguments then it will prompt for the missing information.

POINTS values are calculated as integers rounded down.

