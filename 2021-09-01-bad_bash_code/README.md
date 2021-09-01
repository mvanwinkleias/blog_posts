# Bad Bash Code

## WARNING

This code shows how running commands with arguments that come from untrusted
input can result in arbitrary code exploits.

In general, you should:

* Always quote variables you intend on passing in as single arguments
* Disable options processing using "--" before you pass in untrusted input.

## bad.sh

Shows how options can be passed to *ls*.

## better.sh

Shows how disabling options processing and quoting the input causes *ls* to
treat the single argument as a file name, and not as options.
