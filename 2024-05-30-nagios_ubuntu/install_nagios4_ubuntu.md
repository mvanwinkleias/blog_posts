
```
apt-get install nagios4 nagios4-cgi

a2enmod auth_digest
a2enmod authz_groupfile

# Symlink:

/etc/apache2/sites-enabled/apache2.conf -> /etc/nagios4/apache2.conf


htdigest /etc/nagios4/htdigest.users Nagios4 nagiosadmin
```

```
# /etc/nagios4/cgi.cfg
	use_authentication=1
```

Modify /etc/nagios4/apache2.conf to look like:

```
	<FilesMatch ".*" >
		AuthDigestDomain "Nagios4"
		AuthDigestProvider file
		AuthUserFile    "/etc/nagios4/htdigest.users"
		AuthGroupFile   "/etc/group"
		AuthName        "Nagios4"
		AuthType        Digest
		# Require all   granted
		Require valid-user
	</FilesMatch>

```

```
#/etc/nagios4/nagios.cfg
	* remove localhost config (if you want)
	use_aggressive_host_checking=1

```
	
```
systemctl restart apache2
systemctl restart nagios4
```
