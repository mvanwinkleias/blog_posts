```
genisoimage -quiet -r Documents/ | aespipe -T -e aes256 > documents.iso
# burn it
# decrypt it with:
cat /dev/cdrom | aespipe -d -e aes256 > blah.iso
```
