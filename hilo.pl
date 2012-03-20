#!/mu/bin/perl -w
# /u/qabowers/scripts/perl/fun/hilo           High Low v1.0
#
# *************************************************************
# *  If you have any problems with this script, or questions  *
# *  regarding its use, please contact the author. Your       *
# *  suggestions are welcome.                                 *
# *                                                           *
# *  Quincy Bowers                                            *
# *  qabowers@micron.com                                     *
# *  ph# 333-7323  pager FLASHEDS                           *
# *                                                        *
# ********************************************************* 
#
# User has to guess the random number in 10 guesses.
#
#

srand ( time() ^ ($$ + ($$ << 15)) );   ### seed the random number generator

### DECLARATIONS ###
$gameover = 0;
$level = 0;
$answer = "";
$win = 0;
$loss = 0;
$higher = 0;
$lower = 0;

### MAIN ###

print "Welcome to HiLo!!!\n\n";
print "You need to guess a number in only 10 tries to win.\n";
print "You can pick a difficulty between 1 and 3\n";

while ( $gameover == 0 )
{
    while ( ( $level < 1 ) || ( $level > 3 ) )
    {
        print "\nWhich difficulty level will you play? ";
        chomp ( $level = <STDIN> );
    }

    ### calls the play() function
    play ( $level );

    print "Would you like to play again? ";
    chomp ( $answer = <STDIN> );
    $answer = uc ( $answer );

    $level = 0;

    if ( $answer eq "N" )
    {
        $gameover++;
    }
}

### FUNCTIONS ###

### plays through one game
sub play
{
    my $level = $_[0];
    my @guesses = qw ( x x x x x x x x x x );
    my $rnum = 0;

    if ( $level == 1 )
    {
        $rnum = int ( rand ( ( 20 - 1 + 1 ) - 1 ) );
        print "You picked level $level.  Your target number is between 1 and 20.\n";
    }

    elsif ( $level == 2 )
    {
        $rnum = int ( rand ( ( 100 - 1 + 1 ) - 1 ) );
        print "You picked level $level.  Your target number is between 1 and 100.\n";
    }

    elsif ( $level == 3 )
    {
        $rnum = int ( rand ( ( 1000 - 1 + 1 ) - 1 ) );
        print "You picked level $level.  Your target number is between 1 and 1000.\n";
    } else {
        print "$level is not a valid level!!\n";
        return();
    }

    print "Start guessing!!\n";

    for ( $i = 1; $i <= 10; $i++ )
    {
        print "\n$i> "; 
        chomp ( $guess = <STDIN> );

        if ( $guess == $rnum )
        {
            $guesses[$i] = "win";
            $win++;

            print "Congratulations!!  You guessed the number.\n";

            $higher += grep ( /high/, @guesses );
            $lower += grep ( /low/, @guesses );

            print "win/loss : $win/$loss\n";
            
            if ( $higher > $lower )
            {
                print "You tend to guess higher than lower.\n";
                print "High guesses : $higher\n";
                print "Low guesses  : $lower\n";
            }

            if ( $higher < $lower )
            {
                print "You tend to guess lower than higher.\n";
                print "High guesses : $higher\n";
                print "Low guesses  : $lower\n";
            }

            if ( $higher == $lower )
            {
                print "Amazing!  You have guessed higher just as much as you have guessed lower.\n";
                print "High guesses : $higher\n";
                print "Low guesses  : $lower\n";
            }

            return();
        }

        if ( $guess > $rnum )
        {
            $guesses[$i] = "high";
            print "Hmm, that's too HIGH.\n";
        }

        if ( $guess < $rnum )
        {
            $guesses[$i] = "low";
            print "Hmm, that's too LOW.\n";
        }
    }

    print "What's that?  You couldn't guess it in time!\n";
    $loss++;

    $higher += grep ( /high/, @guesses );
    $lower += grep ( /low/, @guesses );

    print "win/loss : $win/$loss\n";
            
    if ( $higher > $lower )
    {
        print "You tend to guess higher than lower.\n";
        print "High guesses : $higher\n";
        print "Low guesses  : $lower\n";
    }

    if ( $higher < $lower )
    {
        print "You tend to guess lower than higher.\n";
        print "High guesses : $higher\n";
        print "Low guesses  : $lower\n";
    }

    if ( $higher == $lower )
    {
        print "Amazing!  You have guessed higher just as much as you have guessed lower.\n";
        print "High guesses : $higher\n";
        print "Low guesses  : $lower\n";
    }
}
