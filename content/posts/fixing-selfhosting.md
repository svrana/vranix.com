---
title: "Problems with self-hosting"
date: 2022-05-12T09:10:16-07:00
draft: false
---

## Even nerds don't want to run their own servers

This is a quote from Moxie Marlinspike's post [My first impressions of
web3](https://moxie.org/2022/01/07/web3-first-impressions.html). This article is
great critique of web3. He makes a number of good points, but what I found most
interesting was his assertion that people do not want to run their own servers.
And I cannot stop thinking about this and not b/c I think he's wrong, but b/c I think
these challenges can be overcome.

Moxie doesn't go into any detail but here are some of the problems.

## Networking

### DNS

Most servers, and the ones Moxie is talking about, are ones that are meant to be
interacted with outside of your own home. Most of us in the U.S. do not have a static IP,
so you've got to figure out how to get the domain name resolved as the underlying IP
address changes. There are number of ways to solve this or work around it:

1. Use the dynamic IP address and update your bookmarks as it changes. Ok, no, this is not a
real solution.

2. Use dynamic DNS service. This is a service that requires you to run a small piece of
software that updates the IP address that your DNS entry points to. The best place to do
this is on your router, but many routers do not support it or charge for it. Of course,
you'll need to setup your own domain name for this too and setup the service such that
it's able to change the DNS entry for you. This is all do-able if you're reading this, but
no one wants to go through the hassle.

3. If you only need access from your personal devices, you can use
[Tailscale](https://tailscale.com) to create a virtual network between your devices and
your server. You can use the handy "magic DNS" feature such that tailscale will
resolve a hostname to an IP address of your choosing. I.e., on my devices "v.net" resolves
to an address on my local (tailscale) network. The downside is that these services cannot be
accessed by people who you have not authorized, so will not work for everything that you
might like to host.

### Security

If you're running services over the public internet you will likely need to secure
the connection via https. While it's possible to create free certificates that will be trusted by
all browsers without warnings for free (thanks LetsEncrypt!) this is another area of pain.
The certs will need to be renewed occasionally. This is a common enough failure point in
the enterprise. You can figure it out but no one really wants to.

If the service is only for your own use, Tailscale solves this problem as well as you
don't need https at all.

## Storage

Storing data is easy. Making sure you can survive a disk failure is something else
entirely. You can use some sort of RAID, but if your house burns down, you best have an
off-site copy too.

There are plenty of backup solutions of course, but setting it up, ensuring that it continues to
work, and restoring from the backup when it does fail is all work that no one really wants
to do, even those of us that do this kind of thing for a living.

There are companies that are attempting to solve this problem. One promising solution is
[Functionland](https://fx.land/) which ran an [indiegogo
campaign](https://www.indiegogo.com/projects/box-first-free-forever-cloud-storage-alternative#/)
recently for their hardware solution and software platform. The basic idea is that
everyone with one of these boxes stores everyone else's data so that it can be retrieved
again if your box fails. This solution is squarely in the web3 space, backed by a token
which aims to incentivize app developers to create apps that will run on the device.

## Disappearing tech

So, yeah, self-hosting is too much work. I'd prefer not to have all my data backed up to
Google but it's just the easiest option. Many of these problems are tractable and we will
see companies come along and change the landscape in the future. Tailscale is an amazing
example of this. Perhaps Functionland will chip-away at the storage related problems. I'll
be watching.

I do hope we will all be self-hosting in the future, but if so the experience will have to
more like installing a Nest thermostat or setting up a router or a new TV. Sure, none of
these are experiences are particularly pleasant, but you follow the instructions, get
it setup and forget about it.
