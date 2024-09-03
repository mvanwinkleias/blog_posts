We recently had a question about if a group of IP addresses could initiate
connections with something that was behind a firewall.

After getting a pcap, this is the filter we used:

Wireshark filter:
```
! ip.src == 192.168.1.100 && tcp.flags.syn==1 && tcp.flags.ack==0
```

