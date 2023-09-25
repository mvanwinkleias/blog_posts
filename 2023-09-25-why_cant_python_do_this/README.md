```
.
├── lib
│   └── IAS
│       └── Network
│           └── SMTPAuthParse
│               └── Parser.pm
└── parse-it.pl
```

* parse-it.pl

```perl
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
```

* Parser.pm

```perl
package IAS::Network::SMTPAuthParser::Parser;

use strict;
use warnings;

sub new
{
        return bless {};
}

sub say_hello
{
        print "Hello.\n";
}

1;

```