# Package Shell Walkthrough

## Introduction

### Mostly How, Some Why

I will be walking through the steps to create a project.

The rationale for a lot of things will be left out.

Just please trust that this is worth your time.

If you're aware of something better, please tell me.

### Target Audience

* All programmers.
* This will be fairly language agnostic.

You must at least be familiar with how to navigate a filesystem.

# Presentation

## Muddling Your Way Through

Why you should ALWAYS use a project template system.

### A "First" Project - 1

Let's say you need to write a script that does something.

```bash
#!/bin/bash

printf "%s\n" "Hello!"
```

So you put it in a repo:

```
project_1/
└── hello.sh
```

### A "First" Project - 2

But, there's a problem.  You accidentally checked in some temporary files
that your editor created.  So, you add a ```.gitignore``` file.

```
project_1/
├── .gitignore
└── hello.sh
```

### A "First" Project - 3

Now you need to add a README.md file.

```
project_1
├── .gitignore
├── hello.sh
└── README.md
```

### A "First" Project - 4

I could go on.  But you'll notice that a lot of work that
you do with a project isn't actually related to the thing
you originally set out to do.

### A "First" Project - Conclusion

You SHOULD use a template system.

## Complexity

How should an ideal project template behave?!

### Basic Assumptions

* You live in an ecosystem.
> ecosystem - (in general use) a complex network or interconnected system. - google
* Ecosystems are complicated.

### Complexity

* Complexity can lead to problems. (Human error)

Computers Can Handle Complexity.

* Let the computer do the work.


