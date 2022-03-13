---
title: "Nix dev shells from 10,000 feet"
date: 2022-03-09T12:37:53-08:00
highlight: true
series:
- Nix
draft: false
---

## Setting the scene

After neglecting this small place on the internet for years, I cloned the repo with the
hope of quickly updating my resume. This site is constructed with [Hugo](https://gohugo.io),
which is a static site generator written in golang. Anyway, I needed to install that too, so I
edited my [home-manager](https://github.com/nix-community/home-manager) configuration and [switched](https://github.com/svrana/nix-home/blob/main/Makefile#L26),
i.e., I installed it.

## There was an attempt

First thing I tried was running "hugo serve" which starts a web server and serves the
content of your hugo project so changes can be seen as you make them.  But that failed. I
don't remember the errors; it's not important, I knew what happened- years had passed,
non-backward compatible changes had been made to hugo and something I was doing no longer worked.
That's one way of putting it. The more correct way of putting it is that I was using a
much newer version of hugo for a website that was created using a previous version. This was
my own mistake and this wasn't going to happen again. This time I would fix the glitch.

## Enter Nix

I created a flake.nix in the root of my project directory with the following contents.

```nix {hl_lines=[14]}
{
  description = "my hugo flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.bashInteractive ];
          buildInputs = with pkgs; [ hugo awscli2 ];
        };
      });
}
```

This flake isn't any good. I don't even automate the build, but it does what exactly what
I need. It pins the dependencies I need to build and deploy my project, hugo and awscli2.

I also added a .envrc file with the following contents:

```bash
 if ! has nix_direnv_version || ! nix_direnv_version 1.6.0; then
      source_url "https://raw.githubusercontent.com/nix-community/nix-direnv/1.6.0/direnvrc" "sha256-FqqbUyxL8MZdXe5LkMgtNo95raZFbegFpl5k2+Pr
  Cow="
  fi

 use flake
```

Now, assuming you have [nix-direnv](https://github.com/nix-community/nix-direnv) you will
be dropped into a shell with your dependencies each time you enter your project directory.
In this particular case I'm using the version numbers of hugo and awscli2 as supplied by
nixpkgs-unstable. This isn't the only way to do this; you could have pinned to a
particular version of hugo or awscliv2, but this is good enough for this simple project. A
flake.lock file that describes how nix understands the dependencies is generated the first
time you enter the directory:

```nix {linenos=false,hl_lines=[7]}
    "nixpkgs": {
      "locked": {
        "lastModified": 1644972330,
        "narHash": "sha256-6V2JFpTUzB9G+KcqtUR1yl7f6rd9495YrFECslEmbGw=",
        "owner": "NixOS",
        "repo": "nixpkgs",
        "rev": "19574af0af3ffaf7c9e359744ed32556f34536bd",
        "type": "github"
      },
```

I've abbreviated it, but you can see the git sha of the nixpkgs repo to which we are
pinned. nixpkgs (https://github.com/nixpkgs) is the repo that holds our dependencies (and
80k+ software packages for nix) and the instructions of how to build them for the nix
package manager.

## Faster

Of course constructing your flake and .envrc is a lot of work, which is why I didn't do it
by hand. Intead, I  ran [flakify](https://github.com/nix-community/nix-direnv#shell-integration). From there I
just added my two dependencies to the dev shell. 'Course you have to have nix and
nix-direnv installed.


## This fixes nothing

So, yeah, I still had to change my website code to work with the new version of hugo I
pulled in from nixpkgs. But from now on, I can choose when I want to do that, by
updating the dependencies at a time of my choosing.

## Afterward

Nix flakes provide a lot more than developer shells. If you'd like to learn more, check
out Xe's [intro to flakes](https://christine.website/blog/nix-flakes-1-2022-02-21) and
follow that up with xer [flake packages](https://christine.website/blog/nix-flakes-2-2022-02-27).
