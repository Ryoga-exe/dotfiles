# eza
if [[ $(command -v eza) ]]; then
    alias ls='eza --icons'
    alias ll='eza -aahl --icons --group-directories-first'
    alias lt='eza -T -L 3 -a -I "node_modules|.git|.cache|zig-cache|.zig-cache" --icons --group-directories-first'
    alias ltt='eza -T -a -I "node_modules|.git|.cache|zig-cache|.zig-cache" --icons --group-directories-first'
    alias ltl='eza -T -L 3 -a -I "node_modules|.git|.cache|zig-cache|.zig-cache" -l --icons --group-directories-first'
    alias lttl='eza -T -a -I "node_modules|.git|.cache|zig-cache|.zig-cache" -l --icons --group-directories-first'
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

# ghq
if [[ $(command -v ghq) ]]; then
    function repos () {
        local selected_dir=$(ghq list -p | fzf --layout=reverse --border --no-sort +m --query "$LBUFFER" --prompt "go to repo >")
        if [ -n "$selected_dir" ]; then
            cd $selected_dir
        fi
    }
    bindkey '^]' repos
    alias rp=repos
fi

alias v='fd --type f --hidden | fzf --layout=reverse --info=inline --border --no-sort +m --query "$LBUFFER" --prompt "Open with nvim >" --preview "if [ $(command -v bat) ]; then bat --color=always {}; elif [ $(command -v batcat) ]; then batcat --color=always {}; else cat {}; fi" | xargs nvim'
alias -g CC='xclip -selection c'
alias cd-gitroot='cd "$(git rev-parse --show-toplevel)"'
alias cd.=cd-gitroot
alias cdu=cd-gitroot
alias cls=clear
alias take='(){ mkdir -p $1 && cd $1 }'
alias :q=exit
