# mv_diy_pip_repo

DIY pip repo

Python pip repos are both simple and complicated.

Here's something that hopefully makes things less complicated.

## License

copyright (C) 2025 Martin VanWinkle III, Institute for Advanced Study

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

See 

* http://www.gnu.org/licenses/

## Description

* ```src/bin/mv-diy-pip-repo.py file.tar.gz /path/to/repo``` - copies file.tar.gz to /path/to/repo/file/file.tar.gz

# Supplemental Documentation

Supplemental documentation for this project can be found here:

* [Supplemental Documentation](./doc/index.md)

# Installation

## pip

```
make -f pip_Makefile pip
```

## RPM

```
fakeroot make package-rpm
```

## Deb

```
fakeroot make package-deb
```

