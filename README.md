# aeddi’s dotfiles

## Installation

- Fork this repo
- Clone your forked repo in your home directory
    `git clone --recurse-submodules https://github.com/<username>/dotfiles ~/.dotfiles`
- Launch the installation script `cd ~/.dotfiles && ./install all`

## Description

Some configurations (git, vim and zsh) are split into two files: a local and a global.

For example with zsh, if you want to change the configuration on all your hosts,
you'll need to edit the _~/.zshrc_ file and synchronize all your hosts with git.

If you want to add an alias/function only to your current host or add sensitive
information to your configuration (e.g. an authentication token), you'll need to
edit the _~/.zshrc_local_ file.
