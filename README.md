# My dotfiles

A repository with all my linux dotfiles

## ZSH

Add the following to your `/etc/zsh/zshenv` file.

```bash
if [ -z $XDG_CONFIG_HOME ]; then
  export XDG_CONFIG_HOME=$HOME/.config
fi

if [ -d $XDG_CONFIG_HOME ]; then
  export ZDOTDIR=$XDG_CONFIG_HOME/zsh
fi
```
