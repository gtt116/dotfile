# Intro

The repo contains all the dotfile in home path.


## .bashrc not work?
In debian/ubuntu the very start script is `.profile`. When you
create a new user, also create a new directory for the user. If
sysadmin does not put the default .profile in your home directory,
then your .bashrc file will not work.

The normal tree of these file like below:

    ~/.profile
        ~/.bashrc
            ~/.bash_aliases
            /etc/bash_completion


## cheatsheet

### visudo

```
ubuntu   ALL=(ALL)       NOPASSWD: ALL
```
