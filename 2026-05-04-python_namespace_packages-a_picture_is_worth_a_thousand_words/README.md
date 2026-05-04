# Python Namespace Packages - A Picture Is Worth A Thousand Words

This "tutorial" was created for a number of reasons.

* I find existing Python documentation too verbose.
* I complain about people not packaging their things.

I view this as a way to get on the path to fixing those issues.

## Layout

This layout is a slight expansion on the "src" style layout.
It allows you to also organize wrapper scripts if \[project.scripts\]
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


