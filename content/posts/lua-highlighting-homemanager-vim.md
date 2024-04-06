---
title: "home-manager neovim setup: embedded lua highliting"
date: 2024-04-06T06:47:09-07:00
draft: false
---

### Problem

I use home-manager to manage my neovim configuration. When using a plugin, a typical
configuration snippet might look like this:

```nix
{
  plugin = neogit;
  type = "lua";
  config = ''
    require('neogit').setup {
      disable_commit_confirmation = true,
      integrations = {
        diffview = true,
      }
    }
  '';
}
```

This works well enough for me. I like how I can specify the configuration for a plugin
next to where I specify the plugin itself. The only problem is that by default the lua
configuration is highlighted as nix code, i.e., as one large string.

### Solution

Fortunately this a problem treesitter was integrated into neovim to solve. After futzing around bit, I
hacked up a couple treesitter queries for nix files that recognizes the config blocks of
type "lua" as lua code and properly applies the correct syntax highlighting.

To get the same functionality for your home-manager neovim setup, add the contents of [this](https://github.com/svrana/nix-home/blob/main/home/config/nvim/queries/nix/injections.scm) file as
~/.config/nvim/queries/nix/injections.scm to your setup. Additionally this file contains a
query that will make the `extraConfig` block a vim block, so you get the correct syntax there as well.

### Further learning
Want to learn how to do this yourself? TJ describes the process in his video entitled [Magically format embedded languages in Neovim](https://www.youtube.com/watch?v=v3o9YaHBM4Q).
