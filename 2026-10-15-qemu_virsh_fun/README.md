Collection of notes I put together from various sources with the idea of
investigating how to / with the eventual goal of:

* Create some sort of base O.S. image
* Create a virtual machine using that base, but with delta image
* Get consistent networking information
* Execute a command (build, what have you)
* Mount the disk image externally and extract artifacts

Thoughts:

* Thin provisioning?!
* Make a small base O.S. image (like 10G (i know; that's not small)) "pristine"
* Copy "pristine" to "working base"
* Updates
	* execute updates and then commit back to the "working base"
* For workers:
	* overlay a larger file on "working base", and then use lvm to
	extend the root partition to that
	* Execute the command
 	* extract artifacts

# Stuff

## Host Creation and Booting

### Step 1: Create a Virtual Hard Drive

```
qemu-img create -f qcow2 my_guest_disk.qcow2 20G
```


## QCow Backing files

### Steps

#### Create the Overlay (Delta) Image

```
qemu-img create -f qcow2 -b original-base.qcow2 -F qcow2 delta-overlay.qcow2
```

##### Parameter Definition

-b original-base.qcow2: Specifies the path to your original, read-only base QCOW2 file.

-F qcow2: Declares the format of the backing file.
delta-overlay.qcow2: The name of the new file where all changes will be stored. (Note: You do not need to specify a size for the overlay; it inherits the virtual size of the base image.) 

#### Launch the VM Using the Overlay

```
qemu-system-x86_64 -enable-kvm -m 2G -drive file=delta-overlay.qcow2,format=qcow2 ...

```

### Administrative Notes

Keep the base file read-only.

#### Check the backing chain

```
qemu-img info --backing-chain delta-overlay.qcow2
```

#### Committing the changes

* Shut down the VM
* (Back up the base file...)

run commit:
```
qemu-img commit overlay.qcow2
```

## virsh

### Useful management commands:

* virsh list --all # show all vms
* virsh console vm_name # show console
* virsh shutdown vm_name
* virsh destroy vm_name # force stop
* virsh undefine vm_name --remove-all-storage # delete definition and storage

### Creating Hosts

(create disk images as above)

#### Write XML Config:

To do: Find a way to get a base template for this.

```
<domain type='kvm'>
  <name>my-vm</name>
  <memory unit='KiB'>2097152</memory>
  <vcpu placement='static'>2</vcpu>
  <os>
    <type arch='x86_64' machine='pc-q35-6.2'>hvm</type>
    <boot dev='hd'/>
  </os>
  <devices>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/my-vm.qcow2'/>
      <target dev='vda' bus='virtio'/>
    </disk>
    <interface type='bridge'>
      <source bridge='virbr0'/>
      <model type='virtio'/>
    </interface>
    <console type='pty'>
      <target type='serial' port='0'/>
    </console>
    <graphics type='vnc' port='-1' autoport='yes' listen='0.0.0.0'/>
  </devices>
</domain>
```

#### Define and Start the VM

* Option A: Persistent VM (Survives Reboots)
```
# from XML above
virsh define my-vm.xml
virsh start my-vm
```

* Option B: Transient VM (Deleted After Shutdown / Reboot)

```
virsh create my-vm.xml
```



### Running Commands

```
sudo virsh qemu-agent-command <VM_NAME> \
'{"execute": "guest-exec", "arguments": {"path": "/bin/bash", "arg": ["-c", "whoami > /tmp/output.txt"], "capture-output": true}}'
```

### Dumping info

dump device XML

```
virsh dumpxml <VM_name>
```

mac address is under
```
<mac address='...'/>
```

### Networking Information

#### 

These output text things:
```
virsh domiflist <VM_name>
```

```
virsh domifaddr <VM_name>
```

#### Getting Structured Data

Show XML config for "default" network

```
virsh net-dumpxml default
<network connections='2'>
  <name>default</name>
  <uuid>9e71cab0-1e18-44cf-82bb-56e3892f416a</uuid>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:c0:ff:ee'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.128' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
```

(note how ```<bridge name='virbr0' ...>```)

```

Then, in json format here:
* /var/lib/libvirt/dnsmasq/virbr0.status

# Scratch

This is here for posterity; probably will be creating vmhosts
using virsh to 
### Step 2: Set Up Manual Host-Only Networking (Optional)

```
# Create the network bridge
sudo ip link add br0 type bridge
sudo ip address add 192.168.10.1/24 dev br0
sudo ip link set br0 up

# Create a TAP interface for the VM
sudo ip tuntap add dev tap0 mode tap
sudo ip link set tap0 up

# Bind the TAP interface to your bridge
sudo ip link set tap0 master br0
```


### Manually Assemble and Launch the VM

```
qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -smp 4 \
  -m 4G \
  -drive file=my_guest_disk.qcow2,format=qcow2,if=virtio \
  -cdrom /path/to/your/operating-system.iso \
  -boot d \
  -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
  -device virtio-net-pci,netdev=net0 \
  -vga virtio -display sdl,gl=on
```

#### Parameter Definition

-enable-kvm: Enables hardware acceleration for near-native performance. ￼
￼-cpu host: Passes your host machine's exact CPU model and features into the guest. ￼
￼-smp 4: Manually allocates CPU cores (e.g., 4 cores). ￼
￼-m 4G: Specifies the RAM allocation (e.g., 4 Gigabytes). ￼
￼-drive ... if=virtio: Attaches your created QCOW2 disk using virtio for optimal I/O speeds. ￼
￼-cdrom & -boot d: Inserts your operating system ISO file and forces QEMU to boot from the CD-ROM first. ￼
￼-netdev tap...: Links the VM to the tap0 interface you created in Step 2. (To swap to basic user networking instead, replace the entire netdev/device lines with: -netdev user,id=n1 -device virtio-net-pci,netdev=n1). ￼
￼-vga virtio -display sdl,gl=on: Enables 3D graphics acceleration. ￼
￼

### Subsequent Boots

```
qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -smp 4 \
  -m 4G \
  -drive file=my_guest_disk.qcow2,format=qcow2,if=virtio \
  -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
  -device virtio-net-pci,netdev=net0 \
  -vga virtio -display sdl,gl=on
```
