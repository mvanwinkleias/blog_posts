# Setting Up My Git Environment

I have multiple users with multiple Git forges:

* [GitHub](https://github.com):
	* [mvanwinkleias](https://github.com/mvanwinkleias) (work)
	* [mvanwinkle](https://github.com/mvanwinkle) (personal)
* [GitLab](https://gitlab.com):
	* [mvanwinkleias](https://gitlab.com/mvanwinkleias) (work)

It could be difficult to keep track of all of those, but
I have some tools and processes around managing code associated
with those accounts.

## ~/src/git layout

One of the first things I do when I'm bootstraping a git environment
is make a directory structure like this.  Sometimes I use symbolic
links to specify which SSH identity should be used by default for
that forge.

```
~/src/git
├── github.com 
├── github.com-mvanwinkle
├── github.com-mvanwinkleias
└── gitlab.com
```

* github.com - a symbolic link to github.com-mvanwinkleias 
* github.com-mvanwinkle - the directory where personal stuff gets checked out
* github.com-mvanwinkleias - the directory where work stuff gets checked out
* gitlab.com - I only have one account on gitlab; so there's no need to differentiate accounts

## ~/.ssh/config

This is nothing spectacular or new: use your SSH config
and modified domain names to differentiate between accounts.

I didn't come up with this idea, and it's well documented on the internet.

The SSH config is an example from one of my personal machines I do work on.

```
# If I'm coding on a personal machine, then the "original"
# domain name gets an entry for itself using the key for my
# personal account:
host github.com
 HostName github.com
  IdentityFile ~/.ssh/id_rsa_github-mvanwinkle
  User mvanwinkle

host github.com-mvanwinkle
 HostName github.com
  IdentityFile ~/.ssh/id_rsa_github-mvanwinkle
  User mvanwinkle

# This account is for my work at ias.edu
host github.com-mvanwinkleias
 HostName github.com
  IdentityFile ~/.ssh/id_rsa_github-mvanwinkleias
  User mvanwinkleias

```

This allows you to modify the fqdn of a clone to include your username.
For example:

```
git clone git@github.com-mvanwinkleias:theias/ias_package_shell
```
in conjunction with the above, SSH will map: *github.com-mvanwinkleias*
to *github.com* , and will use the appropriate identity.

## [git_cloner.sh](https://github.com/mvanwinkleias/mv_git_repo_utils/blob/master/src/bin/git_cloner.sh)

I've written a Bash script that clones git repos and "automatically organizes"
them.

For example:
```
git_cloner.sh git@github.com-mvanwinkleias:theias/ias_package_shell.git
```

clones to:

```
~/src/git/github.com-mvanwinkleias/theias/ias_package_shell
```

## Benefits

### Collison-free

I think this is the best way to organize your code.  I don't think
it's possible to have "collisions".

### "Automating" Git Pulls

I use 2 scripts together:

* [git_repos_in_this_dir.sh](https://github.com/mvanwinkleias/mv_git_repo_utils/blob/master/src/bin/git_repos_in_this_dir.sh) - lists the direcories under a directory that are git repositories.
* [git_puller.sh](https://github.com/mvanwinkleias/mv_git_repo_utils/blob/master/src/bin/git_puller.sh) - Runs ```git pull``` on a directory

This means that if I have all of my git repos under ```~/src/git``` , I can get updates by doing:

```
cd ~/src/git
git_repos_in_this_dir.sh | xargs -n1 git_puller.sh -v
```

```
----- Pulling: /home/mvanwinkle/src/git/github.com/mvanwinkleias/mv_git_repo_utils
Already up to date.
----- Pulling: /home/mvanwinkle/src/git/github.com/mvanwinkleias/mv_tmux_vi_zen
Already up to date.
----- Pulling: /home/mvanwinkle/src/git/github.com/mvanwinkleias/mv_c_package_template_test
Already up to date.
```

### Backups

I keep the repositories I want to back up (to, say, DVDs) in a different
directory than I keep the repositories I'm working on.

This prevents backing up things like transient files that were put
in the original project directories.

```
export src_base_dir="$HOME"/backups/src
mkdir -p "$src_base_dir"
git_cloner.sh (project I want to back up)
```


```
git_repos_in_this_dir.sh ~/backups/src | xargs -n1 git_puller.sh -v
```

## "Advanced"

### Automatic Bootstrapping

When I start off from scratch I do this:

```
# Check out the repo tools somewhere out of the way
mkdir ~/exports
cd ~/exports
git clone git@github.com:mvanwinkleias/mv_git_repo_utils.git

# Check out the repo tools where the repo tools think they should go
mv_git_repo_utils/src/bin/git_cloner.sh git@github.com:mvanwinkleias/mv_git_repo_utils.git

# Use a relative symbolic link to "install" it:
mkdir ~/bin
cd ~/bin
ln -s ../src/git/github.com/mvanwinkleias/mv_git_repo_utils/src/bin/git_cloner.sh
```

Having things standardized like this across machines / accounts helps a lot with work.


## Conclusion

The collection of configurations and scripts that I use allow
you to:

* have multiple accounts on multiple forges
* organize your code
* choose "default" accounts for each forge


