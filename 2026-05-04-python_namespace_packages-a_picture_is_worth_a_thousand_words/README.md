# Python Namespace Packages - A Picture Is Worth A Thousand Words

This "tutorial" was created for a number of reasons.

* I find existing Python documentation on namespace packages too verbose.
* I complain about people not packaging their things.

I view this as a way to get on the path to fixing those issues.

I recommend you just read through all of the files in namespace_zebra to get
an idea of what's going on.

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

Most of your code should go into a library.  In this example it's
src/lib/animals/zebra.py.

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
