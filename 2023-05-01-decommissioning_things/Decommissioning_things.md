# Decommissioning Things	

I work at a relatively small place, and sometimes provisioned infrastructure
"falls through the cracks" when it was decommissioned.

That's not great, but here's how to clean it up.

## Tickets for All

Ticketing systems are good.  You need a ticketing system.


### Auditing The New

All new changes should reference ticket numbers.  Typically you can do this
in the comments of (say) a firewall object, an IPAM host, etc.

If there is a searchable attribute field that you can use to put a ticket number
in, using that might be a good idea.

### Auditing The Old

Your purpose is to put the onus on replying to a "ticket" to a group
you suspect owns the objects.

Your goal is to make this quick and easy for you to do.  Do this by:

* creating an "Is this <object|rule> still in use?" ticket in that
group's queue
* annotating comments of the objects with the ticket number on (say) the firewall
* (letting it sit)
* "... I have a ticket and nobody responded..." or whatever

Use at your discretion; sometimes people can be bothered by a flood of these things.  Plan accordingly, etc.

## Useful Comments

Let's examine an example firewall rule:

```
src: any
dst: dord.ias.edu
svc: 443
action: accept
comment: [ias.edu #9999999] Allow TCP HTTPS 443 to dord.ias.edu
```

The comment is a bit redundant and is (IMO) not as good a comment as:

```
src: any
dst: dord.ias.edu
svc: 443
action: accept
comment: [ias.edu #9999999] Department of Redundancy Department
```

### Future Proof Comments

This is a fun one to run into:

```
src: any
dst: any
svc: 25
comment: 2019-06 Bob from synergytech put this here
```

Value Added Resellers change, companies get bought out, etc.  Don't put things
in your configuration that won't widthstand time.  Reference ticketing systems
or wiki pages.

Also, don't put dates in the comments... Use tickets.

## Linking Tickets

Our tickets are owned by groups, and are "sub-owned" by individuals.  I (try to) always get a ticket on THEIR side to reference in my tickets.

## Soft Deprovisioning

We do "soft" deprovisioning where things just get marked for removal or deactivated.
Then they can be cleaned up later.  Sometimes stuff happens...

Tickets.

## Checklists

I use Gnome Planner for this

* https://wiki.gnome.org/Apps/Planner

This planner has some stuff roughed in:

* https://github.com/mvanwinkleias/blog_posts/blob/master/2023-05-01-decommissioning_things/server_provisioning_planner.planner

AND, finally (if you've read this far) at one time I put together a Markdown document
that would guide the author through the process:

* https://github.com/mvanwinkleias/blog_posts/blob/master/2023-05-01-decommissioning_things/server_provisioning.md

# Pulling it Together

* Work backward through the provisioning document
* Search for entries using the ticket number

Should get you pretty far.

:)

