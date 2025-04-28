# eza
if [[ $(command -v eza) ]]; then
    alias ls='eza --icons=auto'
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
        local query="$*"
        local selected_dir=$(ghq list -p | fzf --layout=reverse --border --no-sort +m --query "$query" --prompt "go to repo >")
        if [ -n "$selected_dir" ]; then
            cd $selected_dir
        fi
    }
    bindkey '^]' repos
    alias rp=repos
fi

# clipboard
if [[ $(command -v wl-copy) ]]; then
    alias -g CC='wl-copy'
    alias -g CP='wl-paste'
elif [[ $(command -v pbcopy) ]]; then
    alias -g CC='pbcopy'
    alias -g CP='pbpaste'
elif [[ $(command -v xclip) ]]; then
    alias -g CC='xclip -selection c'
    alias -g CP='xclip -selection c -out'
fi

alias v='(){
    target=$(fd --type f --hidden | fzf --layout=reverse --info=inline --border --no-sort +m --query "$LBUFFER" --prompt "Open with nvim >" --preview "if [ $(command -v bat) ]; then bat --color=always {}; elif [ $(command -v batcat) ]; then batcat --color=always {}; else cat {}; fi")
    if [ -n "$target" ]; then
        nvim $target
    fi
}'
alias cd-gitroot='cd "$(git rev-parse --show-toplevel)"'
alias cd.=cd-gitroot
alias cdu=cd-gitroot
alias cls=clear
alias take='(){ mkdir -p $1 && cd $1 }'
alias :q=exit
