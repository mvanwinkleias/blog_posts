# Guides

* https://www.tecmint.com/install-qemu-kvm-ubuntu-create-virtual-machines/
* https://www.golinuxcloud.com/mount-luks-encrypted-disk-partition-linux/
* https://linuxhint.com/uuid_storage_devices_linux/

# Relevant Sequences

## Virtual Machines

Install stuff:
```
sudo apt install -y qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager
```

Setup services:
```
sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd
```

Setup users:
```
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
```

You can now run this:
```
virt-manager
```

## Automount Cryptvolumes

In /etc/fstab:

```
/dev/mapper/encrypted_volume	/mnt/encrypted_volume	ext4	defaults	0	0
```

Look for the UUID of the device:
```
sudo blkid
```

In /etc/crypttab:
```
encrypted_volume	/dev/sdb1	/root/mount_secrets/encrypted_volume
```

Create the password file:
```
dd if=/dev/random bs=32 count=1 of=/root/mount_secrets/encrypted_volume
```

Add the key to the volume:
```
cryptsetup luksAddKey /dev/sdb1 /root/mount_secrets/encrypted_volume
```

## Put libvirt stuff on a larger volume:

```
/var/lib/libvirt/images/ -> /opt/root/lib/libvirt/images
```

## Squid Proxy Server

```
# there's something to allow localnet which you need
# to do as well
# test with curl --proxy http://<proxy_host>:3128
cache_dir ufs /var/spool/squid 25000 16 256
```
