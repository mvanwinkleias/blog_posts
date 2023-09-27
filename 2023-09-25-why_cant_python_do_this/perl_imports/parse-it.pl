#!/usr/bin/perl

use strict;
use warnings;

# Manipulating the library path isn't the focus
# of this exercise; this just allows you to run
# the script from anywhere
use FindBin;
use lib "$FindBin::Bin/lib";

use IAS::Network::SMTPAuthParse::Parser;

my $parser = IAS::Network::SMTPAuthParser::Parser->new();

$parser->say_hello();
