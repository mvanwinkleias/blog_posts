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

## Facts

* You must be able to trust your build/provisioning environment
* If logging in remotely as root from your build/provisioning environment
to the host is considered "insecure", then your build/provsioning
environment is insecure.

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

### Removing Extra Packages

Some distributions are getting good at actually installing a "minimal"
environment.  If packages are going to be removed from a build via kickstart
then you should ensure that a later stage in your kickstart isn't putting them
back.

### Secure

* fail2ban enabled (make sure the underlying firewall software is installed;
*iptables* , *firewalld*, etc.)
* no externally available services except for SSH

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

## Documentation

### Disparate Components

If multiple components in different locations contribute to the same goal
then document it in all locations.

## Auditing

This should only show SSH listening:
```
lsof -i -P -n | grep LISTEN
sshd        939   root    3u  IPv4  16919      0t0  TCP *:22 (LISTEN)
sshd        939   root    4u  IPv6  16921      0t0  TCP *:22 (LISTEN)
```

This should show fail2ban is running:
```
systemctl status fail2ban
● fail2ban.service - Fail2Ban Service
     Loaded: loaded (/usr/lib/systemd/system/fail2ban.service; enabled; vendor preset: disabled)
     Active: active (running) since Fri 2023-05-12 07:58:34 EDT; 3 days ago
       Docs: man:fail2ban(1)
    Process: 929 ExecStartPre=/bin/mkdir -p /run/fail2ban (code=exited, status=0/SUCCESS)
   Main PID: 952 (fail2ban-server)
      Tasks: 3 (limit: 11068)
     Memory: 14.8M
        CPU: 8.698s
     CGroup: /system.slice/fail2ban.service
             └─952 /usr/bin/python3 -s /usr/bin/fail2ban-server -xf start
```

