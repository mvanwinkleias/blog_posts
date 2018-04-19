# Redacting the Same Part of Images

I recently took some screenshots from within a web browser that I used to do a public write-up on a phishing attempt.

I use Ubuntu Mate, and I have a (small) script for taking pictures of the current window:</p>

<pre>
#!/bin/bash
# File:
# ~/bin/cw
gnome-screenshot -w -d 1
</pre>

I take screenshots by pressing alt+f2 , typing 'cw' , pressing enter, and waiting one second.

Which led to screen shots similar to this:

[redact_me_example]: ./redact_me_example.png

![Image I want to redact][redact_me_example]

In the above image I manually removed the sensitive portion of the shot with Gimp's erase tool.

Looks kind of ugly, eh?

# Imagemagick FTW!

Please forgive how terrible this looks, gimp doesn't have a ready-to-use arrow making tool:

[expanded_chop_explained]: ./expanded_chop_explained.png

![Chop dimensions explained][expanded_chop_explained]

In my case, I want to remove the same "row" from every image.  Using a consistent screenshot tool and the same view in the browser allowed me that luxury.

# The Result

Here's the command that removes the bookmarks bar:

<pre>
convert input.png -chop 0x28+0+90 output.png
</pre>

It removes a row "28 pixels tall starting at pixel 90".

[redacted_image]: ./redacted.png

![Redacted][redacted_image]

Which is much cleaner, faster, more consistent, etc.

Thanks for reading!
