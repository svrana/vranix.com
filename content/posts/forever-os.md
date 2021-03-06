---
title: "Migrating to NixOS"
subtitle: "Why I'm changing distributions after 15 years"
date: 2021-01-15
draft: true
---

I've been running Ubuntu LTS on my work and personal machines for many years. I distro
hopped for a while, but by the time I moved over to Ubuntu I had started to feel that the
distributions were more similar than they were different.

The only distribution I have been tempted by since adopting Ubuntu is
[Arch](https://archlinux.org) and almost entirely because of the enormous scope of the
[Arch User Repository](https://wiki.archlinux.org/index.php/Arch_User_Repository).  While
the siren song of the AUR is strong, in the end it was not sufficient and I stayed with
Ubuntu.

Eventually, I also disengaged from the constant churn of UI changes to prefer a mostly
console and keyboard driven experience with [i3](https://i3.org). While I had configured
Gnome to give much the same keyboard-driven experience as i3, changes to Gnome itself
and the inability to control its behavior with a stable configuration file have always made
upgrades painful.

The answer is simple-- I could desire the same thing from the whole distribution!  Yes, I
have source controlled *some* Ubuntu system configuration and have it setup to link these
files at "install" time. But this approach has never felt like a real solution. I disliked
investing in my tooling for this (though invest I did, see my now deprecated
[bash-home-scaffold](https://github.com/svrana/bash-home-scaffold) project) as the
"solution" never felt right. But I couldn't put a finger on what was wrong. And because of
that I could not properly search for a solution. Luckily, the solution found me.

The ability to control the entire distribution with a configuration file is exactly what
NixOS promises.  I say promises, because I have not yet migrated to NixOS. That's coming!
But it's [2020](https://en.wikipedia.org/wiki/Coronavirus_disease_2019) and now that I'm
working from home, my personal machine has become my work machine, so I will need to make
sure this transition can be completed in one night so as not to suffer downtime.

My [next post](/post/nixos-migration-plan) will discuss my plans for the migration. Later
posts will walk you through the setup of NixOS on my laptop.

