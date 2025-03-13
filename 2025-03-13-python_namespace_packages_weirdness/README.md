# Python Namespace Package Weirdness

## Introduction

I had previously thought that Namespace Packages were a
game changer for Python.  Not needing an \_\_init\_\_.py
for everything makes a bit of sense.

However, when I tried to do something that "makes sense" in other languages,
I got a "weird" result.  I can understand how this is happening, but I don't
know why things were designed this way.

### Python Version
```
$ python3 --version
Python 3.10.12
```

## Car

```
plain_car/
├── run_car.py
└── vehicles
    └── car.py
```

### Source

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

### Output

```
$ ./run_car.py 
I am a sedan.  I have 4 doors.
```

## Electric Car

```
electric_car/
├── run_electric.py
└── vehicles
    └── car
        └── electric.py
```

### Source

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

### Output

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

* The existence of *car.py* is causing Python to treat the directory *car* differently.
* I could easily rename *car.py* to something else and continue on my "merry" way

BUT

This seems broken to me.  (Soundness of this particular relational / hierarchical
aside): It seems like it would make sense to BE ABLE to have namespace packages
which have directories named after a base class, (i.e. vehicles.car) and organize
sub-classes thus: (i.e. vehicles.car.electric).


