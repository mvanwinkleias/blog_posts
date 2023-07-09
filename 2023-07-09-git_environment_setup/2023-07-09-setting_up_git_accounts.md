# Setting Up My Git Environment

I have multiple users with multiple Git forges:

* [GitHub](https://github.com):
	* [mvanwinkleias](https://github.com/mvanwinkleias) (work)
	* [mvanwinkle](https://github.com/mvanwinkle) (personal)
* [GitLab](https://gitlab.com): [mvanwinkleias](https://gitlab.com/mvanwinkleias) (work)

It could be difficult to keep track of all of those, but
I have some tools and processes around managing code associated
with those accounts.

## ~/src/git layout

One of the first things I do when I'm bootstraping a git environment
is make a directory structure like this, sometimes using symbolic
links to specify which SSH identity should be used by default for
that forge.

```
~/src/git
├── github.com # a symbolic link to github.com-mvanwinkleias 
├── github.com-mvanwinkle # the directory where personal stuff gets checked out
├── github.com-mvanwinkleias # the directory where work stuff gets checked out
└── gitlab.com # I only have one account on gitlab, so this is just a plain directory
```

## ~/.ssh/config

This is nothing spectacular or new: use your SSH config
and modified domain names to differentiate between accounts.

I didn't come up with this idea, and it's well documented on the internet.

The SSH config is an example from one of my personal machines I do work on.

```
# If I'm coding on a personal machine, then the "original"
# domain name gets an entry for itself using the key for my
# personal account

host github.com
 HostName github.com
  IdentityFile ~/.ssh/id_rsa_github-mvanwinkle
  User mvanwinkle

host github.com-mvanwinkle
 HostName github.com
  IdentityFile ~/.ssh/id_rsa_github-mvanwinkle
  User mvanwinkle

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

```
