# Repo Layout

Note: A .gitignore is very important.  Lots of things leave things.

Here's how we're going to organize things during this tutorial:

```
.
├── README.md
└── src
    ├── bin
    │   ├── some_script.pl
    │   ├── some_script.py
    │   └── some_script.rb
    └── lib
        ├── perl5
        │   └── IAS
        │       └── HelloRepoLayout.pm
        ├── python3
        │   └── IAS
        │       └── HelloRepoLayout
        │           ├── HelloRepoLayout.py
        │           └── __init__.py
        └── ruby2
            └── IAS
                └── HelloRepoLayout.rb
```

All of these languages are unrelated, but they use the same layout.

If you use globally unique library names you don't have to worry about conflicts.


