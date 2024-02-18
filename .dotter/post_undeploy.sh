echo "Remove AstroNvim..."

if [ -d "~/.config/nvim" ]; then
else
    rm -rf ~/.config/nvim
fi
