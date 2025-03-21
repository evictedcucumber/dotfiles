#!/usr/bin/zsh

# Aliases
alias v='nvim'
alias vv='NVIM_APPNAME=neovim nvim'
alias cat='batcat'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias rg='rg --color=always'
alias grep='rg'
alias ls='eza -a -F=always --icons=always --group-directories-first --sort=name -1'
alias la='ls -l -h --no-time --no-user'
alias lt='ls -T -I=".git"'
alias 'z-'='z -'
alias 'z..'='z ..'
# /Aliases

# Functions
mkcd() {
  if [[ -d $1 ]]; then
    cd $1
  else
    mkdir -p $1
    cd $1
  fi
}

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

_fix_cursor(){
    echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)
# /Functions

# Keybinds
bindkey -e

bindkey -s '^f' "y\n"
# /Keybinds

# Styling
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -a -F=always --icons=always --group-directories-first --sort=name -1 $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
# /Styling

# Zinit Setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
# /Zinit Setup

# Completion
autoload -U compinit; compinit

source <(fzf --zsh)

zinit cdreplay -q
# /Completion

# Plugins
zinit ice depth"1"; zinit light Aloxaf/fzf-tab
zinit ice depth"1"; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth"1"; zinit light zsh-users/zsh-autosuggestions
zinit ice depth"1"; zinit light zsh-users/zsh-completions
# /Plugins

# Zoxide
eval "$(zoxide init zsh)"
# /Zoxide

# History
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTFILE="$XDG_STATE_HOME/zshhistory"

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt inc_append_history
# /History

# Options
setopt correct
setopt extendedglob
setopt nocaseglob
setopt numericglobsort
setopt nobeep
# /Options

# Cargo
[[ -d $CARGO_HOME ]] && . "$CARGO_HOME/env"
# /Cargo

# Nix
source $HOME/.nix-profile/etc/profile.d/nix.sh
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
# /Nix

# Prompt
PURE_GIT_PULL=0

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'; zinit light sindresorhus/pure
# /Prompt

# Display `fastfetch`
[[ -o login ]] && fastfetch
# /Display `fastfetch`
