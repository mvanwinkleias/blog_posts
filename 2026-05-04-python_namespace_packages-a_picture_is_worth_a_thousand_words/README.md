# Python Namespace Packages - A Picture Is Worth A Thousand Words

This "tutorial" was created for a number of reasons.

* I find existing Python documentation on namespace packages too verbose.
* I complain about people not packaging their things.

I view this as a way to get on the path to fixing those issues.

## Namespace Packages

Namespace packages in Python are a significant improvement when it comes
to agility.  You just put a file in a directory, and refer to it appropriately
and it works.

You can then tell the package building process to include all packages
in a directory.

## Layout

This layout is a slight expansion on the "src" style layout.
It allows you to also organize wrapper scripts if project.scripts
(mentioned in pyproject.toml) is not cutting it.


```
namespace_zebra/
├── pyproject.toml
└── src
    ├── bin
    │   └── zebra-wrapper.py
    └── lib
        └── animals
            └── zebra.py
```

All of these files are included in this repo.  They are short.

Most of your code should go into a library.  In this example it's
src/lib/animals/zebra.py.

This layout allows you to be very agile with new libraries.
The usage of namespace packages allows you to not use \_\_init\_\_.py .

### src/bin

This is not "necessary".  2 methods for wrapping / calling your program
are provided.  They are not mutually exclusive.  This is one of them,
and is discussed later.

## Initialization

```
python3 -m venv venv
source venv/bin/activate
pip install --editable .
```

## Running

Two examples are shown for entry points.

### \[projects.scripts\]

This creates a wrapper script for you which calls the module / method
specified.

### \[tool.setuptools\] script-files

This copies / installs the program(s) specified.

