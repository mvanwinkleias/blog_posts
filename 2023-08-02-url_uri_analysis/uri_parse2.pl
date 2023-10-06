#!/usr/bin/perl

package IAS::Network::URI::Dumper;

use base 'URI';

our $uri_subs = [
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

sub dump_uri
{
	my ($uri) = @_;

	foreach my $uri_sub (@$uri_subs)
	{
		# print "URI sub: $uri_sub\n";
		$data->{$uri_sub} = $uri->$uri_sub();
	}

	$data->{query} = { $uri->query_form() };

	return $data;

}

package main;

use JSON;

my $url_string = $ARGV[0];
if (! defined $url_string )
{
	print STDERR "Error: First parameter is URL to deconstruct",$/;
	exit 1;
}

my $uri = IAS::Network::URI->new($url_string);
my $json = JSON->new->allow_nonref;

print $json->encode($uri->dump_uri),$/;
