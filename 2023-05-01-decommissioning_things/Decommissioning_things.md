# Decommissioning Things

## Tickets for All

### Auditing The New

All new changes should reference ticket numbers.  Typically you can do this
in the comments of (say) a firewall object, an IPAM host, etc

If there is a searchable attribute field that you can use to put a ticket number
in, that might be a good idea.

### Auditing The Old

* creating an "Is this <object|rule> still in use?" ticket
* putting it in a specific group's queue
* annotating comments of the objects with the ticket number on (say) the firewall
* (letting it sit)
* "... I have a ticket and nobody responded..." or whatever

Use at your discretion; sometimes people can be bothered by a flood of these things.  Plan accordingly, etc.

You just need to have a quick way to make some sort of reliable thing you can find in the future
for questioning this thing's existence.

That's a ticket.

## Useful Comments

Let's say your rule is:

```
src: any
dst: dord.ias.edu
svc: 443
action: accept
```

We try not to repeat what you'd say the rule does in the comments.  For instance:

* \[ias.edu #9999999\] Allow TCP HTTPS 443 to dord.ias.edu

is (IMO) not as good a comment as:

* \[ias.edu #9999999\] Department of Redundancy Department

Our tickets are owned by groups, and are "sub-owned" by individuals.  I (try to) always get a ticket on THEIR side to reference in my tickets.

## Soft Deprovisioning

We do "soft" deprovisioning where things just get marked for removal or deactivated.
Then they can be cleaned up later.  Sometimes stuff happens...  Tickets.

## Checklists

I use Gnome Planner for this

* https://wiki.gnome.org/Apps/Planner

This planner has some stuff roughed in:

* https://github.com/mvanwinkleias/blog_posts/blob/master/2023-05-01-decommissioning_things/server_provisioning_planner.planner

AND, finally (if you've read this far) at one time I put together a Markdown document
that would guide the author through the process:

* https://github.com/mvanwinkleias/blog_posts/blob/master/2023-05-01-decommissioning_things/server_provisioning.md

# Conclusion?




