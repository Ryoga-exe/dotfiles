---@type LazySpec
return {
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  {
    "skanehira/jumpcursor.vim",
    lazy = false,
  },

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            [[           /＾>》, -―‐‐＜＾}           ]],
            [[         ./:::/,≠´::::::ヽ.            ]],
            [[        /::::〃::::／}::丿ハ           ]],
            [[      ./:::::i{l|／  ﾉ／ }::}          ]],
            [[     /:::::::瓜イ＞  ´＜ ,:ﾉ           ]],
            [[   ./::::::|ﾉﾍ.{､  (_ﾌ_ノﾉイ＿         ]],
            [[   |:::::::|／}｀ｽ /          /        ]],
            [[.  |::::::|(_:::つ/         /  neovim!]],
            [[.￣￣￣￣￣￣￣＼/＿＿＿＿＿/￣￣￣￣￣]],
          }, "\n"),
        },
      },
    },
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            ".DS_Store",
            "thumbs.db",
            "node_modules",
          },
          never_show = {
            ".git",
          },
        },
      },
    },
  },
}
