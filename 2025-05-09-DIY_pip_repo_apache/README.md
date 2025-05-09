# DIY Pip Repo With Apache

I went through way too much stuff to figure this out.

## pip doesn't like default apache indexes

It complains about them not being valid html5.  So, you'll need this

* .htaccess

```.htaccess
<IfModule mod_autoindex.c>

IndexOptions SuppressHTMLPreamble
HeaderName /pip/wheel_header.html

</IfModule>
```

and this

* /pip/wheel_header.html

```html
<!DOCTYPE html>
<html>
```

## pip has naming needs

Let's say in your setup.py you have:

```python
setup_args = {
    'name' : "piptest1-YOUR-USERNAME-HERE",
}
```

The resulting files will be named:

```
piptest1_your_username_here-0.0.1-py3-none-any.whl
piptest1_your_username_here-0.0.1.tar.gz
```

piptest1_your_username_here needs to be in a directory named
"piptest1-your-username-here"

## What It Looks Like

Let's say your repo is hosted in /pip 

Your layout will look like:
```
pip
├── .htaccess
├── piptest1-your-username-here
│   ├── piptest1_your_username_here-0.0.1-py3-none-any.whl
│   └── piptest1_your_username_here-0.0.1.tar.gz
└── wheel_header.html
```
