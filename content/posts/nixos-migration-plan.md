---
title: "NixOS Migration Plan"
subtitle: "Leveraging nixpkgs and home-manager to speed the migration"
date: 2021-01-16
draft: true
---

Nix package manager and its packages can be used on any Linux distribution, on a Mac or in
Windows if you use WSL. So, of course I installed it to play around on my Ubuntu machine.
It worked. Searching for packages was a little slow. Nothing amazing; seemed like a fairly
typical experience except that there's certainly more packages available than what's
offered on Ubuntu. Ok, that's nice.

Eventually I stumbled upon [home-manager](https://github.com/rycee/home-manager)
and immediately installed it. It offers a configuration system, based on Nix, to manage
the application configuration that lives in your home directory. This was exactly what I
had been looking for! After just a little toying around I knew I'd found a tool for me.
I've been keeping home directory application configuration in git for years and had
written a [scaffold](https://github.com/svrana/bash-home-scaffold) to install and setup
the packages I use just like I like them. But it was always horrible. Home-manager is a
much better solution. On top of the configuration management, a list of packages
can be provided and it will install them.

My migration plan is to migrate my existing dotfiles to home-manager and install all of
the packages I use on Ubuntu declaritively with home-manager. This has been taking place
in my [nix-home](https://github.com/svrana/nix-home) repository.

One weakness of my scaffold project was dealing with small changes of application configuration
among hosts. There was a method by which I could define an optional custom configuration file per-host
but it meant duplicating that whole file. This is much improved with the home-manager's
module system. I created a simple [settings](https://github.com/svrana/nix-home/blob/master/modules/settings.nix)
module and populated it with the defaults that make sense for my laptop. These settings
can be overridden per-host by a host specific file in the hosts/ directory.
For example,
[bocana](https://github.com/svrana/nix-home/blob/master/hosts/bocana/default.nix)
has more screen real-estate so I scale down the fonts of various applications. I then use these configuration values when configuring the applications. In my alacritty
[configuration](https://github.com/svrana/nix-home/blob/master/home/alacritty.nix), for example, I configure the font size by grabbing the value of alacritty.fontSize like this:

```nix
programs.alacritty = {
  enable = true
  font.size = config.settings.alacritty.fontSize;
}
```

Now that I've switch to home-manager, I maintain the differences between hosts
configurations, not entirely duplicated files for these types of small changes.

For ease of updating home-manager configuration I use this from bash:

```bash
hm() {
  home-manager -f "$DOTFILES/hosts/$HOSTNAME.nix" $@
}
```

So, I'm typically running `hm switch` on my machines to update the configuration or from
within vim I do this:

```vim
nnoremap <silent> <LocalLeader>hs :!home-manager -f $DOTFILES/hosts/$HOSTNAME.nix switch<cr>
```
