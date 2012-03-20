#!/mu/bin/perl -w
# -path to script-          Script Name version #
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

setup_game();

while ( $gameover == 0 )
{
    main_game();
}

sub main_game
{
    take_turn();
    $winner = check_for_winner();

    if ( $winner eq "X" || $winner eq "O" )
    {
        draw_board();
        print "Player $winner won this game.\n";
        $gameover = 1;
        return ( 1 );
    }

    $gameover = check_turns();

    if ( $gameover == 1 )
    {
        $winner = check_for_winner();
        if ( $winner eq "T" )
        {
            draw_board();
            print "It's a cat.\n";
        } else {
            draw_board();
            print "Player $winner won this game.\n";
        }

        return ( 1 );
    }

    if ( $player eq "X" )
    {
        $player = "O";
    } else {
        $player = "X";
    }
}

sub setup_game
{
    @spaces = qw ( 1 2 3 4 5 6 7 8 9 );
    $gameover = 0;
    $player = "X";
}

sub draw_board
{
    system ( "/usr/bin/clear" );
    write ( STDOUT );
}

sub check_turns
{
    if ( grep ( /[1-9]/, @spaces ) )
    {
        return ( 0 );
    } else {
        return ( 1 );
    }
}

sub valid_move
{
    if ( ( $move =~ /[1-9]/ ) && ( $spaces[$move - 1] =~ /[1-9]/ ) )
    {
        return ( 1 );
    } else {
        print "Pick something different!\n";
        return ( 0 );
   }
}

sub take_turn
{
    draw_board();

    $valid = 0;
    while ( $valid == 0 )
    {
        print "Player $player > ";
        chomp ( $move = <STDIN> );

        $valid = valid_move();
    }

    $spaces[$move - 1] = $player;
}

sub check_for_winner
{

    if ( $spaces[0] eq $spaces[1] && $spaces[0] eq $spaces[2] )
    {
        return ( $spaces[0] );
    }

    elsif ( $spaces[3] eq $spaces[4] && $spaces[3] eq $spaces[5] )
    {
        return ( $spaces[3] );
    }

    elsif ( $spaces[6] eq $spaces[7] && $spaces[6] eq $spaces[8] )
    {
        return ( $spaces[6] );
    }

    elsif ( $spaces[0] eq $spaces[3] && $spaces[0] eq $spaces[6] )
    {
        return ( $spaces[0] );
    }

    elsif ( $spaces[1] eq $spaces[4] && $spaces[1] eq $spaces[7] )
    {
        return ( $spaces[1] );
    }

    elsif ( $spaces[2] eq $spaces[5] && $spaces[2] eq $spaces[8] )
    {
        return ( $spaces[2] );
    }

    elsif ( $spaces[0] eq $spaces[4] && $spaces[0] eq $spaces[8] )
    {
        return ( $spaces[0] );
    }

    elsif ( $spaces[2] eq $spaces[4] && $spaces[2] eq $spaces[6] )
    {
        return ( $spaces[2] );
    } else {
        return ( T );
    }
}

format STDOUT =

     @ | @ | @
$spaces[0], $spaces[1], $spaces[2]
    -----------
     @ | @ | @
$spaces[3], $spaces[4], $spaces[5]
    -----------
     @ | @ | @
$spaces[6], $spaces[7], $spaces[8]

.
### the . ends the format declaration
