#!/usr/bin/raku

use IAS::Infra::FullProjectPaths;

class IAS::Infra
	is IAS::Infra::FullProjectPaths
{
	method say_hello()
	{
		say "Hello.";
	}

	method bin_dir()
	{
		return $*PROGRAM.IO.resolve.parent();
	}


	
}
