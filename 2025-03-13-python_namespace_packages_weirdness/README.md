# Python Namespace Package Weirdness

## Introduction

I had previously thought that Namespace Packages were a
game changer for Python.  Not needing an \_\_init\_\_.py
for everything makes a bit of sense.

However, when I tried to do something that makes sense in other languages,
I got a "weird" result.  I can understand how this is happening, but I don't
know why things were designed this way.

### Python Version
```
$ python3 --version
Python 3.10.12
```

## TL;DR

You can't have a directory named **foo** and a namespace package **foo.bar**
under that, AND also have a file called **foo.py** in the same
directory as **foo**

```
├── foo
│   └── bar.py
└── foo.py # This breaks importing from bar.py
```

## A (hopefully) Practical Example

### Car

```
plain_car/
├── run_car.py
└── vehicles
    └── car.py
```

#### Source

```python
#!/usr/bin/python3
# run_car.py
import vehicles.car

sedan = vehicles.car.sedan()

sedan.say_doors()

```

```python
# vehicles/car.py
class sedan:
    def say_doors(self):
        print("I am a sedan.  I have 4 doors.")
```

#### Output

```
$ ./run_car.py 
I am a sedan.  I have 4 doors.
```

### Electric Car

```
electric_car/
├── run_electric.py
└── vehicles
    └── car
        └── electric.py
```

#### Source

```python
#!/usr/bin/python3
# run_electric.py
import vehicles.car.electric

bZ4X = vehicles.car.electric.bZ4X()

bZ4X.say_hello()
```

```python
# vehicles/car/electric.py
class bZ4X:
    def say_hello(self):
        print("Hello.  I am a BZ4X; a 100% electric vehicle from Toyota.")

```

#### Output

```
$ ./run_electric.py 
Hello.  I am a BZ4X; a 100% electric vehicle from Toyota.
```

## Merging the two directories

There are no conflicts on the file system:

```
merged/
├── run_car.py
├── run_electric.py
└── vehicles
    ├── car
    │   └── electric.py
    └── car.py
```

But now:

```
$ ./run_car.py 
I am a sedan.  I have 4 doors.

$ ./run_electric.py 
Traceback (most recent call last):
  File "/var/tmp/example_namespace_problem/merged/./run_electric.py", line 3, in <module>
    import vehicles.car.electric
ModuleNotFoundError: No module named 'vehicles.car.electric'; 'vehicles.car' is not a package
```

## I know...

* The existence of **car.py** is causing Python to treat the directory **car** differently.
	* You can "break" a namespace package by putting a .py file with the same name
	as a directory.
* I could easily rename **car.py** to something else and continue on my "merry" way

BUT

This seems broken to me.  (Soundness of this particular relational / hierarchical
aside) it seems like it would make sense to be able to have namespace packages
which have directories named after a base class (i.e. **vehicles.car**), and organize
sub-classes thus: (i.e. **vehicles.car.electric**).

While namespace packages are an improvement, it now seems that if I want to have
a base class in one "package", and a child class in another, I either have to:
* anticipate that it will be used as a base class, and if I want to use a subdirectory
to organize subclasses I have to name the file containing the base class "differently"
```
vehicle/
├── basecar.py
└── car
    └── electric.py
```

OR
* When I extend the base class **car** do it in such a way that the
subdirectories never have the same name as a python file:
```
vehicle/
├── car.py
└── cartypes
    └── electric.py
```
