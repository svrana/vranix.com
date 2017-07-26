---
date: 2017-07-25T16:09:46-07:00
draft: true
title: Ubuntu name resolution cheatsheat
---

I find myself debugging name resolution failures on Ubuntu often enough that I need to
know how its configured, but not often enough that I remember the details.  So, here's my
cheatsheat.

### dnsmasq

Ubuntu ships with dnsmasq enabled. dnsmasq either answers the dns requests from its
cache or forwards the requests to the dns server configured in `/etc/resolv.conf`.

### NetworkManager

Ubuntu's NetworkManger is also configured to use dnsmasq which is controlled by
the file `/etc/NetworkManager/NetworkManager.conf`. Since 12.04 NetworkManager
queries dnsmasq using the --no-hosts option which instructs dnsmasq to
disregard the /etc/hosts file.  The bug is discussed
[here](https://bugs.launchpad.net/ubuntu/+source/network-manager/+bug/993298).
I prefer to keep dnsmasq enabled and so have opted for the incredibly hacky
solution solution on
[AskUbuntu](https://askubuntu.com/questions/117899/configure-networkmanagers-dnsmasq-to-use-etc-hosts)
However, commenting out the `dns=dnsmasq` section of the NetworkManager.conf
file will also do the trick.

### nsswitch.conf

The libc resolver is controlled by `/etc/nsswitch.conf`. The hosts section of the
file controls the order of lookup mechanism. In 16.04 this section looks like this:

```
hosts: files mdns4_minimal [NOTFOUND=return] dns myhostname
```

The order of these may need to be changed, but hasn't needed adjusting for my particular
needs for many releases.

