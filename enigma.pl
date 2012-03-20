#!/usr/local/bin/perl
#
# VERSION HISTORY
#
# 1.4
#
# - can type exit at any prompt to quit program
#
# 1.3
#
# - Will now nuke anything that isn't a number from your guess.
#   If this results in not enough numbers you will be told to guess
#   again.  If it results in the exact match of numbers then it
#   will acccept your guess.  Don't do stupid stuff like putting in  
#   letters.
#
# 1.2
#
# - Now checks the # of numbers in your guess against the enigma
#
# 1.1
#
# - Added the ability to set different difficulty levels
# 
# 1.0
#
# - Original release
#

use warnings;
use strict;

srand ( time ( ) ^ ( $$ + ( $$ << 15 ) ) );    ### seed the random number generator

my @numbers = qw{ 0 1 2 3 4 5 6 7 8 9 };
my @enigma  = ();
my @guess   = ();

print "ENIGMA v1.2\n";
print "\n";
print "Do you know how to play? (y/n) ";
my $help = <STDIN>;
chomp $help;
$help = uc ( $help );

if ( $help eq "N" )
{
    help();
}
if ( $help eq "EXIT" )
{
    done();
}

print "Choose difficulty (1 - 10) ";
my $qty = <STDIN>;
chomp $qty;
$qty = uc ( $qty );

if ( $qty eq "EXIT" )
{
    done();
}

for ( my $i = 0; $i < $qty; $i++ )       ### put as many unique random numbers in to the enigma as you asked for
{
    my $num = int( rand $#numbers );
    my $deal = $numbers[$num]; 
    push @enigma, $deal;
    splice @numbers, $num, 1;
}

print "The enigma has been created\n";

for ( my $i=1; $i <= 20; $i++ )         ### ask player to guess until they are correct or they have guessed 20 times
{
    print "Turn $i >";
    my $myguess = <STDIN>;
    chomp $myguess;
    $myguess = uc ( $myguess );
    if ( $myguess eq "EXIT" )
    {
        done();
    }
    $myguess =~ tr/0-9//dc;
    @guess = split //, $myguess;
    if ( $#guess != $#enigma )
    {
        print "You have to pick $qty numbers!\n";
        $i--;
        next;
    }
    my ( $nright, $pright ) = checkguess();                   ### checking to see if you got any right
    if ( $nright == $qty && $pright == $qty )
    {
        print "You guessed the enigma correctly!\n";
        exit;
    } else {
        print "You guessed $nright numbers correctly and $pright numbers were in the right position.\n";
    }
}

print "You used up all of your turns!\n";
print "The enigma was @enigma.\n";

sub checkguess
{
    my $nright = 0;
    my $pright = 0;

    for ( my $n = 0; $n < $qty; $n++ )
    {
        foreach my $elem ( @guess )        ### checks to see if any of the numbers you picked appear in the enigma
        {
            if ( $elem == $enigma[$n] )
            {
                $nright++;
            }
        }
    }
    for ( my $n = 0; $n < $qty; $n++ )
    {
        if ( $guess[$n] == $enigma[$n] )
        {
            $pright++;
        }
    }

    return( $nright, $pright );
}

sub help
{
    print << "eop";

Instructions for Enigma

The object of the game is to guess which unique numbers (0-9)
have been placed into the enigma by the random number generator.
You can choose how many numbers you would like the enigma to 
hold, the more numbers the harder it will be for you.  You
will be given twenty turns to solve the enigma.  After each
turn you will be told how many numbers you got correct and
how many numbers were in the correct position.  Below is an
example.

EXAMPLE

The enigma has been created.

Turn 1 > 567
You guessed 0 numbers correctly and 0 numbers were in the right position.
Turn 2 > 568
You guessed 1 numbers correctly and 0 numbers were in the right position.
Turn 3 > 586
You guessed 1 numbers correctly and 1 numbers were in the right position.
Turn 4 > 486
You guessed 2 numbers correctly and 1 numbers were in the right position.
Turn 5 > 384
You guessed 2 numbers correctly and 2 numbers were in the right position.
Turn 6 > 284
You guessed the enigma correctly!

It is important to remember that you must have all of the 
numbers in the correct position, not just have guessed each
one.

If you want to quit you can type 'exit' at any prompt.

eop
}

sub done
{
    print "Thanks for playing Enigma!\n";
    exit();
}
