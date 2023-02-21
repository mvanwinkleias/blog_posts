#!/usr/bin/perl

use strict;
use warnings;

use utf8;
use open qw( :std :encoding(UTF-8) );

use IO::File;
use Text::CSV qw ( csv );
use Data::Dumper;

my $file_name = $ARGV[0]; shift @ARGV;

my $aoh = csv (
	in => $file_name,
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
		if ( defined $record->{'Practices'} && length($record->{'Practices'}) )
		{
			my $new_practices = $record->{'Practices'};
			# print "Practices: $new_practices\n";
			
			my @parts = split(':', $new_practices, 2);
			$parts[0] =~ m/(.*)\s+(\(.+\))/;

			my $title = $1;
			my $short_name = $2;
			my $description = $parts[1];

			$title =~ s/^\s+|\s+$//g;
			$short_name =~ s/^\s+|\s+$//g;
			$short_name =~ s/(\(|\))//g;
			$description =~ s/^\s+|\s+$//g;

			print "## $short_name: $title";
			print "\n\n$description\n";
			# print "Title: $title\n";
			# print "Short: $short_name\n";
			# print "Description:\n";
			# print "$description\n";
			print $/;
		}

		if ( defined $record->{'Tasks'} && length($record->{'Tasks'}) )
		{
			my @parts = split(':', $record->{'Tasks'} , 2);
	
			my $title = $parts[0];
			$title =~ s/^\s+|\s+$//g; 
	
			$parts[1] =~ s/^\s+|\s+$//g;

			print "\n### $title\n",$/;
			print $parts[1], $/;

		}

		if ( defined $record->{'Notional Implementation Examples'} 
			&& length($record->{'Notional Implementation Examples'})
		)
		{
			print "\n#### Examples\n\n";

			my $nies_all = $record->{'Notional Implementation Examples'};
			
			my @nies = split($/, $nies_all);

			foreach my $nie (@nies)
			{
				if ($nie =~ m/^Example\s+(\d+):(.+)/)
				{
					my $number = $1;
					my $rest = $2;

					$number =~ s/^\s+|\s+$//g;
					$rest =~ s/^\s+|\s+$//g;

					print "$number. $rest\n";
				}
				else
				{
					print "$nie\n\n";

				}
			}
		}
		
		if (defined $record->{'References'}  && length( $record->{'References'} ) )
		{
			print "\n#### References\n\n";
			my @references = split("\n", $record->{'References'});
			foreach my $reference (@references)
			{
				print "* $reference", $/;
			}
		}
	}
}
