return {
    {
        'projekt0n/github-nvim-theme',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                -- ...
            })     
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = {'BufNewFile', 'BufRead'},
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "cpp",
                    "c",
                    "typescript",
                    "javascript",
                    "rust",
                    "python",
                    "go",
                    "lua",
                    "bash",
                    "html",
                    "css",
                    "vue",
                    "vim",
                    "yaml",
                    "toml",
                    "ini",
                    "json",
                    "dockerfile",
                    "markdown",
                    "diff",
                    "gitignore"
                },
                highlight = {
                    enable = true,
                    disable = {},
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('nvim-tree').setup({
            })
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
            })
        end
    },
}
