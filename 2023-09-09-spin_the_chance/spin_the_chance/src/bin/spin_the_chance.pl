#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

package Spin::The::Chance::Entity;

use strict;
use warnings;

use Data::Dumper;

sub new
{
	my $type = shift;
	my $options = shift // {};
	my $self = {};

	$self->{age} = $options->{age} // 2;
	$self->{alive} = $options->{alive} // 1;
	$self->{name} = $options->{name};

	return bless $self, $type;
}

sub run
{
	my ($self) = @_;

	# print Dumper($self),$/;
	# print "Hello.\n";

	$self->live();
}

sub live
{
	my ($self) = @_;

	my $failure = 1 + int(rand($self->{age})) ;

	if ($failure == $self->{age})
	{
#		print "I ded!",$/;
		$self->{alive} = 0;
	}

	$self->{age}++;
}

sub say
{
	my ($self) = @_;

	if ($self->{name})
	{
		print "Name:  ", $self->{name},$/;
	}
	print "Age:   ", $self->{age},$/;
	print "Alive: ", $self->{alive},$/;

}

1;

package Spin::The::Chance;

sub new
{
	my $type = shift;
	my $options = shift;
	my $self = {};

	return bless $self, $type;

}

sub run
{
	my ($self) = shift;

	my $total_ages = 0;
	my $generations = 200000;
	my $generation = 1;
	while ( $generation < $generations )
	{
		my $spce = Spin::The::Chance::Entity->new({
			'name' => $generation,
		});

		while ($spce->{alive})
		{

			$spce->live();
			# $spce->say();
			# <STDIN>;
		}
		$total_ages += $spce->{age};
	
		$generation++;

	}

	print "Generations: $generations",$/;
	print "Average age: ", $total_ages / $generations, $/;

}

1;

package main;

# my $spce = Spin::The::Chance::Entity->new();
# $spce->run();

my $spc = Spin::The::Chance->new();
$spc->run();

exit;
