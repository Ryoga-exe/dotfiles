# eza
if [[ $(command -v eza) ]]; then
    alias ls='eza --icons'
    alias ll='eza -aahl --icons --group-directories-first'
    alias lt='eza -T -L 3 -a -I "node_modules|.git|.cache" --icons --group-directories-first'
    alias ltt='eza -T -a -I "node_modules|.git|.cache" --icons --group-directories-first'
    alias ltl='eza -T -L 3 -a -I "node_modules|.git|.cache" -l --icons --group-directories-first'
    alias lttl='eza -T -a -I "node_modules|.git|.cache" -l --icons --group-directories-first'
fi

# bat
if [[ $(command -v bat) ]]; then
    alias cat=bat
elif [[ $(command -v batcat) ]]; then
    alias cat=batcat
fi

# neovim
if [[ $(command -v nvim) ]]; then
    alias vim=nvim
    alias vi=nvim
fi

alias -g CC='xclip -selection c'
alias cdgitroot='cd "$(git rev-parse --show-toplevel)"'
alias cd.=cdgitroot
alias cls=clear
alias take='(){ mkdir -p $1 && cd $1 }'
