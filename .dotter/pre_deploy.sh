echo "Setup AstroNvim..."

if [ -d "~/.config/nvim" ]; then
    git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
else
    echo "~/.config/nvim exists, skipped..."
fi
