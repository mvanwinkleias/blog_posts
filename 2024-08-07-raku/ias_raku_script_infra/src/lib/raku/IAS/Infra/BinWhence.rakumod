#!/usr/bin/raku

class IAS::Infra::BinWhence
{
	method bin_dir()
	{
		return $*PROGRAM.IO.resolve.parent();
	}
	
}
