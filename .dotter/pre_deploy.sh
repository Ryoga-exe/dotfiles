echo "Setup AstroNvim..."

if [ -d "~/.config/nvim" ]; then
    echo "~/.config/nvim exists, skipped..."
else
    git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
fi
