<?php

# $shell_user = posix_getpwnam('johndoe');
# var_dump($shell_user); // will show an array and key 'dir' is the home dir

// not owner of running script process but script file owner
// $home_dir = posix_getpwnam(get_current_user())['dir'];
// var_dump($home_dir); 

//function getHomeDir($user = posix_getpwuid(posix_geteuid())['name'] )

//$home_dir=posix_getpwnam(get_current_user())['dir'];
function getInfraHomeDir($options=array())
{
	// They specified the user whose home dir they want so we give them that
	if ( isset($options['user']) ) { return posix_getpwnam($options['user'])['dir']; }

	$wanted_user = null;
	
	// If the environment variable is not set, getenv will return a blank string
	// instead of just not setting the variable.  That's why we're mixing the tertiary
	// operator and the coalescing operator on the same line.

	$home_mode = getenv('INFRA_HOME_MODE') != '' ? getenv('INFRA_HOME_MODE')
		: $options['mode'] ?? 'user';
	// print("Home mode: $home_mode\n");
	// exit;
	if ( $home_mode == 'user' ) {
		// print ("We want the user of the process.\n");

		$wanted_user = getenv('LOGNAME') != '' ? getenv('LOGNAME') ?? getenv('USER');
	}
	elseif ($home_mode == 'owner'){
		// print ("We want the owner of the file.\n");
		$wanted_user = get_current_user();
	}
	else{
		print("Bad mode: " . $home_mode . "\n");
	}

	// print("Wanted user: $wanted_user\n");

	return posix_getpwnam($wanted_user)['dir'];
}
// var_dump(getenv('USER'));
var_dump(getHomeDir());

?>
