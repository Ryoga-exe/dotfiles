# .zshenv

# Env
export LESSCHARSET='utf-8'
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
export EDITOR=nvim
export NODE_ENV="development"

# WSL
if [[ $(command -v wslpath) ]]; then
    export WINHOME="/mnt/c/Users/$USER/"
fi
. "$HOME/.cargo/env"
