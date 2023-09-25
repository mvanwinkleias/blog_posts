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

Then run it:

```
marty@marty perl_imports/ $ ./parse-it.pl 
Hello.
marty@marty perl_imports/ $
```

<br>

How do I get python to do the same thing?

```
lib/
└── ias
    └── network
        └── smtpauthparse
            ├── __init__.py
            └── parser.py
```

I'd like to be able to say:

```python3
import ias.network.smtpauthparse.parser

parser = ias.network.smtpauthparse.parser()
```
