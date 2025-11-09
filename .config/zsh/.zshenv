# .zshenv

# Env
export LESSCHARSET="utf-8"
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
export EDITOR=nvim
export NODE_ENV="development"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GEM_HOME=$HOME/gems
export PATH=$PATH:$GEM_HOME/bin

# WSL
if [[ $(command -v wslpath) ]]; then
    export WINHOME="/mnt/c/Users/$USER/"
fi
