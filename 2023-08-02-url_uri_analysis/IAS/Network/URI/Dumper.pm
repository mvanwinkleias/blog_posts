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

1;
