#!/usr/bin/perl

use URI;
use JSON;

my $uri_subs = [
	'scheme',
	'opaque',
	'path',
	'fragment',
	'as_string',
	'as_iri',
#	'canonical', Returns an object
	'secure',
	'has_recognized_scheme',
];
my $url_string = $ARGV[0];

if (! defined $url_string )
{
	print STDERR "Error: First parameter is URL to deconstruct",$/;
	exit 1;
}

my $uri = URI->new($url_string);

my $data = {};

# $data->{host} = $uri->host();

foreach my $uri_sub (@$uri_subs)
{
	# print "URI sub: $uri_sub\n";
	$data->{$uri_sub} = $uri->$uri_sub();
}

$data->{query} = { $uri->query_form() };

my $json = JSON->new->allow_nonref;

print $json->encode($data),$/;
