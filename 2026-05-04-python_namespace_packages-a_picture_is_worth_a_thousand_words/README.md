# Python Namespace Packages - A Picture Is Worth A Thousand Words

This "tutorial" was created for a number of reasons.

* I find existing Python documentation on namespace packages too verbose.
* I complain about people not packaging their things.

I view this as a way to get on the path to fixing those issues.

I recommend you just read through all of the files in namespace_zebra to get
an idea of what's going on.

## Audience

This is not a Python tutorial, or a programming tutorial.
This is more of a project layout / architecture tutorial.


## Namespace Packages

Namespace packages in Python are a significant improvement when it comes
to agility.  You just put a file in a directory, and refer to it appropriately
and it works.

You can then tell the package building process to include all "packages"
in a directory.

## Layout

This layout is a slight expansion on the "src" style layout.
It allows you to also organize wrapper scripts if project.scripts
(mentioned in pyproject.toml later) is not cutting it.


```
namespace_zebra/
├── pyproject.toml
└── src
    ├── bin
    │   └── zebra-wrapper.py # optional
    └── lib
        └── animals
            └── zebra.py
```

All of these files are included in this repo.  They are short.

If you are still in an exploratory phase for whatever you're writing, then
putting all of your code in something like src/bin/zebra-wrapper.py is okay.

When you start to abstracting things away, then ost of your code should go into a library.
In this example it's src/lib/animals/zebra.py.

This layout allows you to be very agile with new libraries.
The usage of namespace packages allows you to not need \_\_init\_\_.py .

### Annotated relevant sections of pyproject.toml

```toml
[tool.setuptools]
# Include all packages under this directory:
package-dir = {"" = "src/lib"}

# Optional:
# If you want to have a custom wrapper for your program
# put it in src/bin , and this causes it to be installed
# into venv/bin
script-files = ["src/bin/zebra-wrapper.py"]

[project.scripts]

# Optional:
# If you want a wrapper script set up for you that calls
# a subroutine inside of a file, use this:
zebra-bray = "animals.zebra:do_zebra_run"
```
## Initialization

```
python3 -m venv venv
source venv/bin/activate
pip install --editable .
```

You can now edit the files under src/lib without reinstalling them.

## Running

Two examples provided as "entry points".

### pyproject.toml - \[projects.scripts\]

This creates a wrapper script in venv/bin for you which calls the module method
specified.

```
$ zebra-bray 
kwa-ha!
```

### pyproject.toml - \[tool.setuptools\] script-files

This installs the program(s) specified into venv/bin .

```
$ zebra-wrapper.py 
kwa-ha!
```

## Building a pip

```
python3 -m build
```

## Making a pip repo (yay)

At the time I came up with all of this pip was a bit finicky about some
things.  So, some of this might not be necessary, but here's what can you do...

### Apache Directory Export and Config

* Create a directory and export it with apache
* pip complains about directory indexes not being valid html5, so you'll need
to put this in .htaccess :
```
<IfModule mod_autoindex.c>

IndexOptions SuppressHTMLPreamble
HeaderName /pip/wheel_header.html

</IfModule>
```
* and then in /pip/wheel_header.html :
```
<!DOCTYPE html>
<html>
```

### Adding pips to the directory

This repository contains ias_private_pip_repo , which is a pip that helps
you add pips to pip repo directories.  Build it, install it, run it with:
```
ias-private-pip-repo-add \
    namespace_zebra-0.1.0-py3-none-any.whl \
    namespace_zebra-0.1.0.tar.gz \
    /path/to/pip_repo
```

### Configure pip to use the new repo

* ~/.config/pip/pip.conf

```
[global]
extra-index-url = http://localhost:80/pip_repo/
```

... and you're off

## Conclusion

It took a bit to get Python to this point, and with all of the history
it has it's a bit difficult to find a clear, direct path to building
your own pips (in an approved way), making a pip repo, and installing
them.

My hope is that this will help bring sanity and simplicity.
