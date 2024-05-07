#!/usr/bin/perl

use strict;
use warnings;

use utf8;
use open qw( :std :encoding(UTF-8) );

use IO::File;
use Text::CSV qw ( csv );
use Data::Dumper;

use Getopt::Long;

my @OPTIONS=(
	'print-references!',
);

my $OPTIONS_VALUES = {
	'print-references' => 0,
};

GetOptions($OPTIONS_VALUES, @OPTIONS)
or die "Bad option.  Available: ".$/.Dumper(\@OPTIONS).$/;

my $file_name = $ARGV[0]; shift @ARGV;

my $aoh = csv (
	in => $file_name,
	encoding => "UTF-8",
	headers => 'auto',
);

# print Dumper($aoh),$/;

dump_markdown($aoh);

exit;

sub dump_markdown
{
	my ($aoh) = @_;

	my $record;

	foreach my $record (@$aoh)
	{
		if ( defined $record->{'Function'} && length($record->{'Function'}) )
		{
			print "\n# ", $record->{'Function'},$/;
		}

		if (defined $record->{'Category'} && length($record->{'Category'}) )
		{
			my $new_category = $record->{'Category'};
			my @parts = split(':', $new_category, 2);
			$parts[1] =~ s/^\s*//g;	
			print "\n## ", $parts[0], $/;
			print "\n$parts[1]\n\n";
		}

		if (defined $record->{'Subcategory'} && length($record->{'Subcategory'}) )
		{
			print "* ", $record->{'Subcategory'}, $/;
		}

		if (defined $record->{'Implementation Examples'} && length($record->{'Implementation Examples'}))
		{
			my @implementation_examples_parts = split($/, $record->{'Implementation Examples'});
			foreach my $iep (@implementation_examples_parts)
			{
				print "\t* $iep\n";
			}
			# print $record->{'Implementation Examples'},$/;

			print $/;
		}

		if (
			$OPTIONS_VALUES->{'print-references'}
			&& defined $record->{'Informative References'}  && length( $record->{'Informative References'} ) )
		{
			print "\n#### References\n\n";
			my @references = split("\n", $record->{'Informative References'});
			foreach my $reference (@references)
			{
				print "* $reference", $/;
			}
		}
	}
}
