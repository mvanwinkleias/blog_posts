#!/usr/bin/raku

use IAS::Infra::BinWhence;
use IAS::Infra::FullProjectPaths;

class IAS::Infra
	is IAS::Infra::BinWhence
	is IAS::Infra::FullProjectPaths
{
	multi method say_hello()
	{
		say "Hello.";
	}

	
}
