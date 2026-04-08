local gh = function(x) return "https://github.com/" .. x end

vim.pack.add({
  --{ src = gh("rebelot/kanagawa.nvim") },
  --{ src = gh("folke/tokyonight.nvim") },
  { src = gh("navarasu/onedark.nvim") },
  { src = gh("lukas-reineke/indent-blankline.nvim") },
  { src = gh("nvim-lua/plenary.nvim") }, -- dep for telescope
  { src = gh("nvim-telescope/telescope.nvim") },
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1")  },
  { src = gh("hat0uma/csvview.nvim") },
})

-- -----------------
-- setup colorscheme
-- -----------------

require("onedark").setup({ style = "darker" })
vim.cmd("colorscheme onedark")

-- Make vertical split separator a nice cyan
vim.cmd("hi WinSeparator guifg=#008888")

-- ----------------------
-- setup indent-blankline
-- ----------------------

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require("ibl.hooks")

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

-- ---------------
-- setup telescope
-- ---------------

local ts_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', ts_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', ts_builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>ft', ts_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', ts_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', ts_builtin.help_tags, { desc = 'Telescope help tags' })

-- ---------------
-- setup blink.cmp
-- ---------------

require("blink.cmp").setup({
  keymap = { preset = "super-tab" },

  appearance = {
    nerd_font_variant = "mono" -- or 'normal'
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

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
    sorts = { "exact", "score", "sort_text" },
  },
})

-- ------------------
-- setup csvview.nvim
-- ------------------

require("csvview").setup({
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
})
--cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },

--------------------------------------------------------------------------------
