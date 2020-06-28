# Infrastructure Thoughts - Starting From Scratch

After reworking a Kickstart file for the EL8 family of Linux, I began to wonder
how preparing to move to a new major release compares to "completely starting
over".

Of course, having things already in place, which are compatable with the new
release would automatically differ from starting from scratch.  LDAP, Kerberos,
DHCP, DNS, PXE, etc, tend to at least be usable from one major release to the
next.  Configuring those services as a client, and as a server do change
sometimes.

Of course you're going to have to rework somethings.  Configuring LDAP
authentication changed from 7 to 8, but /etc/security/access.conf appears
to be mostly similar.

But, what if along the way you examined how you'd do things from scratch?  This
is something that I looked into as a matter of just not wanting to miss
anything that I could be using.

# Infrastructure Development

## Cycles - Cost / Benefit

Cycle iteration, I guess, was the first important thing that
came to mind.  The sooner you can reach states of reliability and repeatability
the better.

Some things are order dependent, some are not.

I'm going to assign cost / benefit scores to each cycle.  Maybe I'll be wrong.

The scales will be on a 1-5, where 
* Cost: 1 is the most expensive, 5 is the cheapest.
* Benefits: 1 is the least beneficial.  5 is the most beneficial.

Multiplying these numbers together, maybe they could be used to decide
what to work on next.

## Code Repositories

Git, Subversion, etc, make good code repositories.  Sometimes, in the case of
documentation, they make okay artifact repositories.

## Artifact Repositories

Whenever any artifact repository is mentioned, rules should be made governing
CRUD stuff:

* C - Create
* R - Read
* U - Update
* D - Delete

Versioning filesystems make good artifact repositories.

Sometimes you don't want files to truly be deleted until you need the space to
be available, or a certain amount of time has gone by.

# Stages

One of the goals for the early stages is to keep things lean to the point
where "your work" can be backed up to one CD, DVD, USB key, etc.  Come up
with a reasonable backup schedule and stick to it for the "core" bit of
infrastructure.

## Artifact Repository Creation - "External" Store of Documentation

* Cost: 5
* Benefits: 5

Sign up for a free git repository thing.  Create a private repository.

Put your notes which:

* you gathered from public sources
* you don't consider secret

in there.  Depending on your level of secrecy, you could put your Kickstart
files there (provided you use best security practices).

## Saving Local Offline Copies of O.S. Installation Media

* Cost: 5
* Benefits: 3

One could argue that provided the internet is working you could always get a copy
of CentOS 8, but dumb things happen and sometimes you really need a copy handy.
And sometimes you want it on a read-only medium.  I'd use DVDs for this.

## Network Topology

Decide what the network is going to look like, and document it.  The first
system you build is going to be a multi-purpose system that will need a fixed
address.

## The First System

This will host many things.  PXE, DNS, DHCP, and an http server.

I recently heard of DNSMASQ, http://www.thekelleys.org.uk/dnsmasq/doc.html .

It seems perfect for getting started.

## Artifact Repository: Local Online Copy of O.S. Installation Media

This is can be done by:

* Mounting an installation ISO
* Copying files somewhere
* Exporting the directory with an HTTP server

Having local copies of the installation media online will speed up your
development cycles.

