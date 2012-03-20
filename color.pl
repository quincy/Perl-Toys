#!/usr/bin/perl -w
# /u/qabowers/bin/color         Color v1.0
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
# USAGE
# $ color -help 
#
%colors = ( 
    k => "\e[40m\e[30m#\e[0m",
    r => "\e[41m\e[31m#\e[0m",
    g => "\e[42m\e[32m#\e[0m",
    y => "\e[43m\e[33m#\e[0m",
    b => "\e[44m\e[34m#\e[0m",
    m => "\e[45m\e[35m#\e[0m",
    c => "\e[46m\e[36m#\e[0m",
    w => "\e[47m\e[37m#\e[0m",
    _ => " ",
);

%forecolors = ( 
    k => "\e[30m",
    r => "\e[31m",
    g => "\e[32m",
    y => "\e[33m",
    b => "\e[34m",
    m => "\e[35m",
    c => "\e[36m",
    w => "\e[37m",
    _ => " ",
);

%backcolors = ( 
    k => "\e[40m",
    r => "\e[41m",
    g => "\e[42m",
    y => "\e[43m",
    b => "\e[44m",
    m => "\e[45m",
    c => "\e[46m",
    w => "\e[47m",
    _ => " ",
);

if ( grep ( /help/, @ARGV ) )
{
    while ( <DATA> )
    {
        print;
    }
    die "\n";
}

if ( ! ( defined @ARGV ) )
{
    load();
} else {
    $filename = $ARGV[0];
}

open ( FILE, "$filename" );

while ( <FILE> )                                        ### while the file is open stick it's contents into an array
{
    push ( @text, $_ );
}

close ( FILE );

chomp ( @text );

system ( '/usr/bin/clear' );

foreach $elem ( @text )                                 ### each line of the array will, in turn, be given to match() for processing
{
    match ( $elem );
    print "\n";
}

sub load
{
    print "File? ";                                     ### prompt for filename
    $filename = <STDIN>;
}

sub match
{
    my $var = $_[0];

    if ( $var =~ /^\[(\w):(\w):(.+?)\]/ )               ### look for something that looks like [f:b:*]
    {
        $len = 7;                                       ### set $len to be used later to strip the above match off of the line
        print "$forecolors{$1}$backcolors{$2}$3\e[0m";  ### print out the character according to the coding
    }

    elsif ( $var =~ /^(\w)/ )                           ### look for something that looks like 'b'
    {
        $len = 1;                                       ### set $len to be used later to strip the above match off of the line
        print "$colors{$1}";                            ### print out the color as coded
    }

    $newstring = substr $var, $len;                     ### strip off the number of characters referenced in $len from the front of the line.

    if ( $newstring ne "" )                             ### if there is stil stuff left on the line, call match again with what is left
    {
        match ( $newstring );                           ### call match again with the remaining portion of the line
    }
}

__END__

COLOR HELP SCREEN

USAGE

$ color
File? [filename]

Where [filename] is the path to a file made up of various color codes.

Color Codes

To draw solid colors use the following 1 character color codes:

black   = k  blue    = b
red     = r  magenta = m
green   = g  cyan    = c
yellow  = y  white   = w
whitespace  = _

To draw a different forecolor then the backcolor:

[f:b:*]

Where f is one of the above color codes, this will be the foreground.
Where b is one of the above color codes, this will be the background.
Where * is the character that you want drawn in the foreground.

You can not have any leading whitespace on a line, you must use the
color code '_' for any whitespace.  For an example look at /u/qabowers/art/xmas
