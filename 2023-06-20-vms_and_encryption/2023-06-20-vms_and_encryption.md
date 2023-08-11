# Guides

* https://www.tecmint.com/install-qemu-kvm-ubuntu-create-virtual-machines/
* https://www.golinuxcloud.com/mount-luks-encrypted-disk-partition-linux/
* https://linuxhint.com/uuid_storage_devices_linux/
* https://packetpushers.net/ubuntu-extend-your-default-lvm-space/

# Setting Up A Lab Environment

## Acquire ISOS

Download a bunch of them somehow

## Setup a proxy

First thing I recommend is setting up a debian VM
with squid installed as a proxy.

## Set up a "work" VM

This is going to be reasonably sized so you can get work
done on it, and maybe use it as a recon box.

Build an lubuntu VM.

I name it ```lubuntu-2204-base-01```

You don't seem to be able to
build it and use the proxy at the same time.

Once it's built:
* Make the screen saver just blank
	* Preferences -> Screen Saver -> Mode -> Blank Screen Only
* configure apt to use the proxy machine
* do a dist-upgrade on it,
and watch the proxy logs to make sure it's being used.

Only turn it on to upgrade it, or to install default packages
you think are useful for the rest of the builds.

Because the rest of the builds will use the caching proxy,
you can err on the side of not installing the tools on the
base install, and have a list of packages you like to have
installed after the machine is cloned.

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

### Verify

> Your system needs to have an Intel VT-x (vmx) processor or AMD-V (svm) processor.

```
egrep -c '(vmx|svm)' /proc/cpuinfo
```

```
apt-get install -y cpu-checker
kvm-ok
```

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

### Accessing virt-manager remotely (sound works!)

Set up authorized keys.

```
virt-manager -c 'qemu+ssh://user@192.168.1.11/system'
```

## Virtual Machines, Sample Network Layout

Simple stuff to get started.  Maybe set up the proxy first
so stuff will be faster later.

* .9 - utility VM1 (head1)
* .10 - utility VM2 (head2)
* .11 - proxyvm1
* .12 - proxyvm2

### Squid Proxy Server

* /etc/squid/squid.conf

```
# test with curl --proxy http://<proxy_host>:3128
http_access allow localnet
cache_dir ufs /var/spool/squid 25000 16 256
```

## VNC

### Server

Packages:

```
tigervnc-standalone-server
```

Config:

```
vncpasswd
```

Server:

```
vncserver -localhost no
```

### Client

Packages:

```
tigervnc-viewer
```

SSH Tunnel:

```
ssh -L localhost:55555:192.168.122.160:5901 user@vmhost
```

Viewer:

```
xtigervncviewer localhost::55555
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

```
sudo netplan apply
```

#### Extending The Default Partition

```
lvdisplay
lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv 
lvdisplay
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

```
service networking restart
```

#### Useful Client Packages

```
wireshark
tcpdump
tmux
nmap
gdebi
pavucontrol
openssh-server
fail2ban
```

#### Useful Browser Plugins


#### Useful Server Packages

```
net-tools
openssh-server
fail2ban
```

#### Test user stuff

```
echo "DenyUsers test" >  /etc/ssh/sshd_config.d/deny_test_user.conf
```

### Centos Stream 9

```
yum install epel-release
yum install fail2ban
```

## apt proxy configuration

```/etc/apt/apt.conf.d```:

```
Acquire::http::Proxy "http://192.168.122.11:3128/";
Acquire::https::Proxy "http://192.168.122.11:3128/";
```
