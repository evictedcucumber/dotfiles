export DOTFILES_HOME="$HOME/repos/dotfiles"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_DIRS"

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

export KEYTIMEOUT=1
export EDITOR=nvim

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export GPG_TTY=$(tty)

# Aliases
alias v='nvim'
alias cat='batcat'
alias cp='cp -i'
alias mv='mv -i'
alias rmt='rmtrash -v'
alias mkdir='mkdir -p'
alias rg='rg --color=always'
alias grep='rg'
alias ls='eza -a -F=always --icons=always --group-directories-first --sort=name -1'
alias la='ls -l -h --no-time --no-user'
alias lt='ls -T -I=".git"'

# Zoxide Setup
eval "$(zoxide init zsh)"
alias 'z-'='z -'

# ZINIT Setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Completion
autoload -Uz compinit && compinit

zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# History
HISTSIZE=10000
HISTFILE="$XDG_STATE_HOME/zshhistory"
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Options
setopt autocd

bindkey -e

# Functions
function mkcd() {
  if [[ -d $1 ]]; then
    cd $1
  else
    mkdir -p $1
    cd $1
  fi
}

# Fix cursor issues
_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Cargo
. "$HOME/.cargo/env"

# # Load oh-my-posh
# eval "$(oh-my-posh init zsh --config /home/ethan/.config/omp/config.toml)"

# Starship
eval "$(starship init zsh)"

# Display fastfetch
fastfetch
