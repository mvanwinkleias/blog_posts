sssd-kcm is awesome, and I suggest using it.  You can kinit with your regular user principal, and with your root principal, and switch between the two.

```
apt-get install sssd-kcm
```

* /etc/krb5.conf :
```
[libdefaults]
    default_ccache_name = KCM:
```

```bash
# systemctl restart sssd
# systemctl start sssd-kcm.socket
# systemctl enable sssd-kcm.socket
```

```bash
$ kinit marty@DS.IAS.EDU
$ kinit mvanwinkle/root@DS.IAS.EDU
$ kswitch -p marty@DS.IAS.EDU
$ kswitch -p mvanwinkle/root@DS.IAS.EDU
# etc
```


