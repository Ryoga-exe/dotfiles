vim.g.mapleader = " "

local keymap = vim.keymap

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

keymap.set('i', 'jj', '<ESC>')

keymap.set('n', '<leader>nh', ':nohl<CR>')
