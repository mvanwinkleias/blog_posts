[//]: # ( This is one way of doing comments in Markdown.  )
[//]: # ( Comments must be surrounded by parenthesis. )

[//]: # ( Progression through this document can be tracked by: )
[//]: # ( * Adding or removing markdown )
[//]: # ( * Adding or removing commented markdown, or commenting markdown )

# Server Provisioning

## Editing

The source code for this document is here:

* https://github.com/mvanwinkleias/blog_posts/blob/master/2023-05-01-decommissioning_things/server_provisioning.md

There are Markdown Comments "hidden" in this file.  If you don't see them, and you're "editing" this,
then you're editing the wrong thing.



## Purpose

This document describes the systems that are used to track and deploy things at IAS.

It's designed to mostly be "top down" for Creation / Provisioning , and "bottom up" for decomissioning.

It can also serve as a checklist for a project.  Comments are embedded in the Markdown that can be un-commented.

## Checklist

For provisioning, in general:

* Make sure there's an RT ticket for the provisioning process.
* Use that ticket in the comments field, extensible attributes, etc for the project in systems affected by this provisioning.

For decomissioning, in general:

* Update the RT ticket used for provisioning to denote that things related to this deployment should be removed.
* Work from the bottom of this document, up, undoing what is necessary.

### Documentation

[//]: # ( Usually, having something documented is better than not having it documented. )
[//]: # ( There are preferences for where things should be documented, and how. )
[//]: # ( Mostly, you want things documented in a system that's good for keeping track of state. )

* Design Documentation
* Implementation Documentation
* Administrative
	* Run-books
* User Documentation

#### Decomissioning Documentation

* At the top of the document, put "DEPRECATED".
* Include a link to the RT ticket tracking the state of the decomissioning.
* If the project is being replaced by another project, put in links to the other projects documentation pages, tickets, etc.

#### RT Tickets

Tickets log work that was performed.

RT Ticket numbers also provide a way to convienently search for entities related to each other in disparate systems.

#### Wiki / Google Docs / Drupal

Wiki / Google Docs / Drupal document the Environment.  Lists of documentation systems, along with what could go in there is documented in the comments.

[//]: # ( * Links to Documentation )
[//]: # ( * Capacity planning and Allocation )
[//]: # ( 	* Space )
[//]: # ( 	* Electricty )
[//]: # ( 	* Heating / Cooling )
[//]: # ( 	* Networking )
[//]: # (   * Virtual Machines )
[//]: # (   * AWS )
[//]: # ( * Purchasing )
[//]: # ( 	* Purchase orders )
[//]: # ( 	* Warranties )
[//]: # ( 	* Vendors, resellers )
[//]: # ( * Service Level Agreements )
[//]: # ( * Obtaining Support )
[//]: # ( * Associated RT Tickets )
[//]: # ( * Administrators )
[//]: # ( * Owners )
[//]: # ( * Stakeholders )
[//]: # ( * Customers )
[//]: # ( * Service Level Agreements )
[//]: # ( 	* Maintenance hours )

[//]: # ( Some documentation systems: )
[//]: # ( * https://www.net.ias.edu )
[//]: # ( * https://www.ias.edu )
[//]: # ( * https://www.itg.ias.edu )

### IPAM

If it's not in IPAM, it doesn't exist!

Make sure to put an RT Ticket number in the extensable attributes for your IPAM objects.

This way, when you decomission things, you can just search for the ticket.

* Networks
* Host objects
* CNAMES
* Plain A records
* etc

### Puppet

* Roles

### Switch Gear

* Port / VLAN assignments

### Virtual Machines

### Certificates

Certificates get tickets separate from hardware tickets.

Certificate creation, renewal, and replacement need to be documented in a ticket.

Testing methods for verifying proper encrypted communications should be documented.

#### Decomissioning

* Revoke certificates
* Clean up certificates inside of LastPass

#### Subject Alternates

### Firewall

The firewall is IP based.

All firewall rules and objects must reference an RT ticket.  This is typically done in the comments for the rules, and objects, etc.


#### Objects

##### Hosts

* Static NAT / Hide NAT

##### Networks

* Hide NAT
* DMZ

#### Groups

#### Role-Based Rules

* A heading is created for the role.
* Sources and targets are specified in groups

#### Individual Rules

* A heading is created for the project

#### Other Considerations

* Bastion host access

### Load Balancing (F5)

* Certificates
* Pools
* Virtual Servers

### OpenVPN

* LDAP Entries
* Firewall entries

### Monitoring

It's not in production if it isn't monitored.

Checks should be commented with documentation and / or ticket numbers.

Documentation for checks can include:

* Standard operational procedures
* Who to contact if there are problems

#### Nagios

#### Pingdom
