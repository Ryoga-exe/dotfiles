# .zshrc

# History
if [[ ! -d "${XDG_STATE_HOME:-$HOME/.local/state}"/zsh ]]; then
    mkdir -p -m 700 "${XDG_STATE_HOME:-$HOME/.local/state}"/zsh
fi
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}"/zsh/history
export HISTSIZE=100000
export SAVEHIST=1000000
setopt inc_append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2

# Alias
source $ZDOTDIR/.zalias

# Utilities
setopt auto_cd
setopt no_flow_control

# fzf
function select-history() {
    BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
    CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# fnm
eval "$(fnm env --use-on-cd)"

# Sheldon
eval "$(sheldon source)"

# Starship
if [[ $(command -v starship) ]]; then
    eval "$(starship init zsh)"
fi
