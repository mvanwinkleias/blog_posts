#!/usr/bin/perl


use FindBin;
use lib "$FindBin::Bin";

use IAS::Network::URI::Dumper;

use JSON;

my $url_string = $ARGV[0];
if (! defined $url_string )
{
	print STDERR "Error: First parameter is URL to deconstruct",$/;
	exit 1;
}

my $uri = URI->new($url_string);
my $json = JSON->new->allow_nonref;
$json->canonical([1]);
$json->pretty([1]);

print $json->encode(IAS::Network::URI::Dumper::dump_uri($uri)),$/;
