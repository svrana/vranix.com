---
title: "Introducing Geniveev: a CLI for boilerplate generation"
date: 2024-04-08T06:47:09-07:00
draft: false
---

I worked on a product with a microservice architecture for a while. As one does working
in such an environment, I found myself creating a lot of little services. Each of these services
was first described as a service in a protobuf file. The services were compiled into
an interface which you would then implement. We also used a tool for injecting
dependencies to make creating these services easier.

This is a long way for me to say that to start a new project, I would
generally have to create three files in different (new) directories. Like any self-respecting
developer, I would hunt down one such file, create the new directory, copy an existing file to
the new directory, do some deletion and substitions and work my way to the next file until I was done.
This process felt hokey because it was; the developer experience was lacking.

At the time, I really wanted a code-generation tool that I could configure
once for our project and then just call on the command line and have it create the file
stubs in the right places, creating the new directories as appropriate, perhaps with the name of the
new service and the usual imports already provided. I scoured the internet for such a tool, but couldn't
find one. I wanted to write it myself, but one doesn't just have the time to create a tool that will
likely cost you a day of work and only save you 5 minutes of time every couple of weeks..
well, maybe you do, but this was a seed stage company and we were focused on shipping, not
solving my ickies of copy/pasta work.

But then I found myself hacking a project of my own, this time also with protobufs, and
having the same problem. This time however, I had time to spend on writing that tool to
remove the drudgery and so I did. This became
[geniveev](https://github.com/svrana/geniveev). I will let the repository readme describe
the format of the configuration file and how to use it, but the result is that in my
project (with the example configuration file in the repo) I can now run

```sh
geniveev service-stubs --service_name foo
```

This will create a stub foo protobuf file and its implementation file, creating the new
directories in the correct spots for the project. My developer ickies are solved. Perhaps
it could help you too.
