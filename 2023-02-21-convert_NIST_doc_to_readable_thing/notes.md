## Security Requirements for Internal Only Software

If you're just starting out, here's what I would focus on.

## Don't commit credentials / sensitive information

Learn how to refer to credentials that are located outside
of the source repository.

### Inputs

#### Sanitize Inputs

This is always taken in context.  If it's a non-critical program that
will only be run by trusted people, then you're requirements for
sanitizing inputs can be more relaxed.

If it's a critical process or it might be run by untrusted people
then do the best you can at this.

#### Make Mistakes and Tampering Hard

Use Inputs Securely.  This is different from sanitizing inputs.
A clean bullet in a clean gun can still do bad things.

#### Principle of least privilege

Only give / allow permission to do what's needed.

### Make "doing the right" thing easy.

* Wrapper scripts
* Documentation / Examples

### Don't make doing the right thing difficult.

If, when you're writing software, your actions prevent or make following
"good advice" difficult, then you're doing something wrong.


