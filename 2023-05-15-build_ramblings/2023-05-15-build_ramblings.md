Individual components interact or produce things in a series of steps.

Each step should be:
* auditable
* repeatable
* testable
* "Secure"

Something that's easy to audit has these attributes:

* clearly stated purpose
* clearly stated intentions
* clear and well-defined functionality
* audit trail (VCS history, package versions, etc)

## Minimizing Failure Opportunities

Minimize:

* External dependencies
* Cramming things in to what would otherwise be clearly defined steps


## Kickstart

A kickstart file should do the minimum required in order to
provision a machine with an operating system so that it is:

* secure
* remotely administratable

THAT'S IT.

You can even argue that my slipping the build package in violates
these principles.

### Secure

* fail2ban enabled
* no externally available except for SSH

### Remotely Administratable

#### Package Repositories

The machine should have already had the repositories enabled in order
to fulfill the requirements.

Adding extra repositories early increases the chances of something going
wrong.

## Optimizations Outside of the Scope of a Secure Build

* Extra repositories - the earlier they are in the build, the sooner
they can be automatically scanned
* Build prep routing - A machine can become many things, and experimenting
can take a long time.  Having this available ahead of time saves much time.


