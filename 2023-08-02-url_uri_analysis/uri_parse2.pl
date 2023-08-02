#!/usr/bin/perl

use Data::Dumper;
use URI;

my $url_string = $ARGV[0];

if (! defined $url_string )
{
	print STDERR "Error: First parameter is URL to deconstruct",$/;
	exit 1;
}

my $uri = URI->new($url_string);

my %query = $uri->query_form();

# print $uri->opaque,$/;
print $uri->host(),$/;
print Dumper(\%query),$/;
