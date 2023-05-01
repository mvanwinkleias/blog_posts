# Decommissioning things step by step

## Tickets for All

### Auditing The New

All new changes should reference ticket numbers.  Typically you can do this
in the comments of (say) a firewall object, an IPAM host, etc
* If there is a searchable attribute field that you can use to put a ticket number
in, then you can do that

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

We try not to repeat what you'd say the rule does in the comments.  For instance:

	* [ias.edu #9999999] Allow TCP HTTPS 443 to dord.ias.edu

When the rule is (something like):
```
src: any
dst: dord.ias.edu
svc: 443
action: accept
```

is (IMO) not as good a comment as:

	* [ias.edu #9999999] Department of Redundancy Department

Our tickets are owned by groups, and are "sub-owned" by individuals.  I (try to) always get a ticket on THEIR side to reference in my tickets.

## Checklists

I use Gnome Planner for this

* https://wiki.gnome.org/Apps/Planner


