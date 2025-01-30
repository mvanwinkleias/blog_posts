# Creating Encrypted DVDs

## Needs Polish

This is a draft.  Some commands might not work exaclty as written.

## Introduction

I still back some things up to DVD, but for sensitive things I'd like
for those backups to be encrypted.

Of course, you could (say):

* symmetrically encrypt a file with GPG
* burn a data disk with a file system and put that file on it

But then you'd still need to "interact" with GPG.

## Goals

* Minimize user-interaction:
	* Get a DVD where you put it in, access it, and get prompted for a password
* To not need to know the file size of the "intermediate" encrypted file ahead of time

Currently, I've found out how to do either-or.

## Put in the DVD.  Access it.  Get Prompted


```
# Create a sparse file.  Approximate maximum size we can write to a dvd is 4g:
truncate --size 4g file.iso

cryptsetup luksFormat ./file.iso
cryptsetup luksOpen ./file.iso encrypted_volume
mkfs.ext4 /dev/mapper/encrypted_volume
mkdir /mnt/encrypted_volume
mount /dev/mapper/encrypted_volume /mnt/encrypted_volume
```

On my system the resulting size of the file on disk is 146M.

Copy whatever files you want to /mnt/encrypted_volume , but don't exceed the available space

Then:
```
umount /mnt/encrypted_volume
cryptsetup luksClose
```

If you burn file.iso as an iso image, all 4GB will be written to the DVD.
If you burn it as a data file, all 4GB will be written to the DVD.

HOWEVER

tar(1) is capable of recognizing sparse files.  So, if you:
```
tar --sparse -czvf file.iso.tar.gz file.iso
```

the resulting file should not cause all 4GB to be written to DVD
(unless there really is that much data).

You'll lose the ability to just put the DVD into the computer and get prompted
BUT you won't need to spend time writing all of that data to the DVD when you burn it.

## Not knowing the file size ahead of time

Here, genisoimage could easily be tar, or some other archive command.

aespipe is the real hero.  If you burn documents.iso as an iso image to DVD
then (I THINK...) the DVD itself will contain absoultely no information
about the nature of its contents.

But at the same time, a user must know how to decrypt it.

```
genisoimage -quiet -r Documents/ | aespipe -T -e aes256 > documents.iso
# burn it
# decrypt it with:
cat /dev/cdrom | aespipe -d -e aes256 > blah.iso
```
