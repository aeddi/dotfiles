# aeddi’s dotfiles

![Demo of the install script](https://i.imgur.com/gUM2ae2.gif)

## Installation
The installation script will offer you to make a backup of your old configuration files if they exist.

It will also try to install dependencies during execution. You can avoid installing dependencies by saying *No* when the script prompts you for permission.

Tested on: Arch Linux, Debian 8, CentOS 7 and macOS 10.11.

- Fork this repo
- Clone your forked repo in your home directory `git clone https://github.com/<username>/dotfiles ~/.dotfiles`
- Launch the installation script `~/.dotfiles/install.sh`

## Description

Some configurations (git, vim and zsh) are split into two files: a local and a global.

For example with zsh, if you want to change the configuration on all your hosts, you'll need to edit the *~/.zshrc* file and synchronize all your hosts with git.

If you want to add an alias/function only to your current host or add sensitive information to your configuration (e.g. an authentication token), you'll need to edit the *~/.zshrc_local* file.

### vim
Vim configuration comes in 3 versions:

- **Full version** is good for decent CPU, not for RPi or small VM
- **Medium version** comes without completion feature: *Reactivity++*
- **Light version** comes without completion, syntax checker and colorscheme: *Startup speed+++* (4x faster) and *Reactivity+++*

Plugins|Full|Medium|Light
-------|:--:|:----:|:---:
YouCompleteMe|✓|-|-
Ultisnips|✓|-|-
Syntastic|✓|✓|-
Tomorrow theme|✓|✓|-
Better Whitespace|✓|✓|✓
Vim Template|✓|✓|✓
EditorConfig|✓|✓|✓
Vim commentary|✓|✓|✓
delimitMate|✓|✓|✓
EasyMotion|✓|✓|✓
Rainbow|✓|✓|✓
MatchIt|✓|✓|✓
Vim Repeat|✓|✓|✓
js-beautify|✓|✓|✓
Signify|✓|✓|✓
Hardtime|✓|✓|✓
Gundo|✓|✓|✓
CtrlP + tjump|✓|✓|✓
Fugitive|✓|✓|✓
Recover.vim|✓|✓|✓
Tabulous|✓|✓|✓
Airline + themes|✓|✓|✓

### zsh
Zsh configuration comes in 2 versions:

- **Full version** with plugins: *zsh-history-substring-search*, *zsh-completions* and *zsh-bd*
- **Light version** with no plugin

There are two separate files for [functions](https://github.com/aeddi/dotfiles/blob/master/zsh/functions) and [aliases](https://github.com/aeddi/dotfiles/blob/master/zsh/aliases). If you want to use the Github/Bitbucket repo. creation function, you'll need to add tokens with correct permissions inside your *~/.zshrc_local* file:
```zsh
export GITHUB_TOKEN=XXXXXX
export BITBUCKET_TOKEN=YYYYYY
```
