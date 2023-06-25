# Guides

* https://www.tecmint.com/install-qemu-kvm-ubuntu-create-virtual-machines/
* https://www.golinuxcloud.com/mount-luks-encrypted-disk-partition-linux/
* https://linuxhint.com/uuid_storage_devices_linux/

# Relevant Sequences

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

## virt-manager

### Install stuff

```
sudo apt install -y qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager
```

### Setup services

```
sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd
```

### Setup users

```
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
```

### Put libvirt stuff on a larger volume:

```
/var/lib/libvirt/images/ -> /opt/root/lib/libvirt/images
```

### Change default network config

```
Edit -> Preferences -> Enable XML exiting
```

Edit the default network to start distributing IPs at 128.

## Virtual Machines

Simple stuff to get started.  Maybe set up the proxy first
so stuff will be faster later.

* .9 - utility VM1 (head1)
* .10 - utility VM2 (head2)
* .11 - proxyvm1
* .12 - proxyvm2

### Squid Proxy Server

```
# there's something to allow localnet which you need
# to do as well
# test with curl --proxy http://<proxy_host>:3128
cache_dir ufs /var/spool/squid 25000 16 256
```

## System Config Notes

### Ubuntu Server

#### Static Networking

/etc/netplan/00-installer-config.yaml

```
network:
  ethernets:
    eno1:
      dhcp4: false
      addresses:
        - 192.168.1.37/24
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
      routes:
        - to: default
          via: 192.168.1.1
```

### Debian

#### Static Networking

```
iface enp1s0 inet static
address 192.168.122.11
netmask 255.255.255.0
gateway 192.168.122.1
dns-nameservers 192.168.122.1
```
