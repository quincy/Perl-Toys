#!/mu/bin/perl -w
#/u/qabowers/bin/jumble       Jumble v1.0
#
# *************************************************************
# *  If you have any problems with this script, or questions  *
# *  regarding it's use, please contact the author. Your      *
# *  suggestions are welcome.                                 *
# *                                                           *
# *  Quincy Bowers                                            *
# *  qabowers@micron.com                                     *
# *  ph# 333-7323  pager FLASHEDS                           *
# *                                                        *
# *********************************************************
#
# Jumble will find every possible anagram for the word (or jumbled letters)
# that you pass to it on the command line.  It uses the file /u/qabowers/notes/words
# as the dictionary.  Obviously if the word is not in that file it will not find it.
#
# VERSION HISTORY
#
# VERSION 1.0
#
# - First release
#
#\--- START SCRIPT ---/

#open ( WORDS , "/u/qabowers/notes/words" );                  ### open the dictionary
open ( WORDS , "/usr/share/dict/words" );                  ### open the dictionary
$x = join ( '', sort alpha split ( //, lc ( $ARGV[0] ) ) );  ### split the word into an @ and sort them by
                                                             ### alpha, then join them back together as a $
while ( <WORDS> )
{
    chomp;                                                   ### kill any \n's
    $y = join ( '', sort alpha split ( //, lc ( $_  ) ) );   ### look at a word in the dict, and do the same split/join thing as above
    if ( $x eq $y )
    {                                                        ### compare the two $'s we split/ordered/joined to see if they match exactly
        print "$_\n";                                        ### if they match then print the word we were looking at in the dictionary
    }
}

sub alpha                                                    ### sub that does the alphabetical ordering for us
{
    $a cmp $b;
}
