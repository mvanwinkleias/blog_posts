#!/usr/bin/raku

class IAS::Infra::FullProjectPaths
{
	has IO::Path $install_path = IO::Path.new("/opt/IAS/");

	method is_in_src()
	{
		if (self.bin_dir().IO.resolve.parent.basename eq "src")
		{
			return True;
		}
		else
		{
			return False;
		}
	}

	method src_dir
	{
		return self.bin_dir().resolve.parent();
	}

	multi method lib_dir()
	{
		return self.lib_dir('raku');
	}

	multi method lib_dir(Str $lang = "raku")
	{
		if (self.is_in_src())
		{
			return self.bin_dir().IO.resolve.parent.sibling("lib/$lang");
		}
		else
		{
			my $new_path = IO::Path.new($install_path);
			return $new_path.add("lib/$lang");
		}
	}
}

