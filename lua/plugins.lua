-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Colorscheme
    --"mhartington/oceanic-next",
    --"sainnhe/sonokai",
    --"catppuccin/nvim",
    --"EdenEast/nightfox.nvim",
    {
      "rebelot/kanagawa.nvim",
      config = function(plugin, opts)
        require("kanagawa").setup(opts)
        vim.cmd("colorscheme kanagawa")
        vim.cmd("hi WinSeparator guifg=#008888")
      end
    },

    -- Indent lines
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

        local hooks = require "ibl.hooks"
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#7A3A41" })  -- #E06C75
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#8F713E" })  -- #E5C07B
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#315F87" })  -- #61AFEF
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#805A3A" })  -- #D19A66
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#4F6E49" })  -- #98C379
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#713F8A" })  -- #C678DD
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#2E646C" })  -- #56B6C2
        end)

        require("ibl").setup({ indent = { highlight = highlight } })
      end
    },

    -- Telescope
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local builtin = require('telescope.builtin')
        --vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = 'Telescope git files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      end
    },

    -- Completion
    {
      "saghen/blink.cmp",
      version = "1.*",

      ---@module "blink.cmp"
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = "super-tab" },

        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono'
        },

        completion = {
          documentation = { auto_show = true },
          accept = { auto_brackets = { enabled = false } },
          menu = {
            draw = {
              columns = {
                { "kind_icon", "label", gap = 2 },
                { "kind" },
              },
            },
          },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = {
          implementation = "prefer_rust_with_warning",
          sorts = { "exact", "score", "sort_text" },
        },
      },
      opts_extend = { "sources.default" }
    },

    -- CSV
    --{ "hat0uma/csvview.nvim", parser = { async_chunksize = 50 } },
    {
      "hat0uma/csvview.nvim",
      ---@module "csvview"
      ---@type CsvView.Options
      opts = {
        parser = { comments = { "#", "//" } },
        keymaps = {
          -- Text objects for selecting fields
          textobject_field_inner = { "if", mode = { "o", "x" } },
          textobject_field_outer = { "af", mode = { "o", "x" } },
          -- Excel-like navigation:
          -- Use <Tab> and <S-Tab> to move horizontally between fields.
          -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
          -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
          jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
          jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
          jump_next_row = { "<Enter>", mode = { "n", "v" } },
          jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
      },
      cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  -- consider installing luarocks
  rocks = { enabled = false },
})
