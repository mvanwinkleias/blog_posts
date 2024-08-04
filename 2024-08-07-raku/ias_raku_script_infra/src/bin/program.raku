#!/usr/bin/raku

use lib $*PROGRAM.IO.resolve.parent.sibling('lib/raku');
use lib "/opt/IAS/lib/raku";
use IAS::Infra;

my $app = IAS::Infra.new();

$app.say_hello();
say $app.bin_dir();
say $app.is_in_src();
say $app.lib_dir();
