# Shaka, When the Walls Fell

If you're anything like me, you might have **foolishly** written a Python script that is indented with tabs instead of spaces.

<pre>
find . -type f -iname "*.py" -print0 | while IFS= read -r -d $'\0' line; do expand -i -t 4 $line | sponge $line ; done
</pre>

Somebody should submit a patch to the Linux Kernel to change all of the tabs to spaces.  Get with the times poeple!!!1

Here's what you can put in ~/.vim/after/ftplugin/python.vim if you want to avoid some problems up front:

* [python.vim](./python.vim)

