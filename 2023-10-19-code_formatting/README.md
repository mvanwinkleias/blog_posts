# Tabs...

First off:  Tabs are tabs.  They're not "spaces".  They're tabs.

They specify:
* an indentation level
* a column separator

# Questionable Indentation Styles

I have NO idea why people indent things like this:
```c
int some_long_function_name( int param1,
                             int param2,
                             int param3
                           );
```

You ONLY "lose" one line if you do it like this:
```c
int some_long_function_name(
	int param1,
	int param2,
	int param3
);
```

If I change "some_long_function_name" to "some_much_longer_function_name_that_does_something",
and I use the "bad" indentation style, here's the result:

```c
int some_much_longer_function_name_that_does_something( int param1,
                                                        int param2,
                                                        int param3
                                                      );
```
Why would you want this?
It seems like this indentation style might have been a good idea when your function
names were short.  And now that they're long, you can't admit that all of the other
code you wrote was indented poorly.

Here's what it looks like when you don't do that nonsense:

```c
int some_much_longer_function_name_that_does_something( 
	int param1,
	int param2,
	int param3
);
```
For languages that use curly braces that start a code block,
I don't do this:
```c
if (something == something_else) {
	do_something();
}
```

I do this:
```c
if (something == something_else)
{
	do_something();
}
```

They're code BLOCKS.
The braces for code line up.
You only "lose" one line.
People write code in books to save space.
Your code doesn't need to look like it came from a book.

For specifying data structures, I DO put the braces on the same line:

```python
d = {
	key1: 1,
	key2: 2,
	key3: 3,
}
```

To me this says: "This is not code.  It's data."


