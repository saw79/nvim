-- Modes
--   normal = "n"
--   insert = "i"
--   visual = "v"
--   visual_block = "x"
--   terminal = "t"
--   command = "c"

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, silent = true, expr = true }

local t_mv_h = "<C-w>h"
local t_mv_j = "<C-w>j"
local t_mv_k = "<C-w>k"
local t_mv_l = "<C-w>l"
local t_esc = "<C-\\><C-n>"

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------------------
-- Basic utilities
--------------------------------------------------------------------------------

-- Easier macros
--nnoremap Q @q -- @@ is now DEFAULT!

-- Replace in line
keymap("n", "<leader>rl", ":s/", { noremap = true })
-- Replace in file
keymap("n", "<leader>rf", ":%s/", { noremap = true })

-- increment/decrement
keymap("n", "<leader>=", "mz<S-v><C-a>`z", opts)
keymap("n", "<leader>-", "mz<S-v><C-x>`z", opts)

-- misc
keymap("n", "<leader>ch", ":noh<cr>", opts)

keymap("n", "<leader>ec", ":e ~/.config/nvim/", { noremap = true })
keymap("n", "<leader>en", ":e ~/notes.md<cr>", opts)

--------------------------------------------------------------------------------
-- Navigation
--------------------------------------------------------------------------------

-- change cwd directory to current file location
keymap("n", "<leader>cde", ":cd %:h<cr>", opts)
vim.keymap.set(
  "n",
  "<leader>cdt",
  function()
    return
      t_mv_l ..
      "acd \"" ..
      vim.fn.expand('%:p:h') ..
      "\"<cr>" ..
      t_esc ..
      t_mv_h
  end,
  expr_opts)

-- file explorer
keymap("n", "<leader>ex", ":Lex 20<cr>", opts)

-- buffer navigation
keymap("n", "<leader>bl", ":w<cr>:ls<cr>:b ", opts)
keymap("n", "<leader>bb", ":w<cr>:b#<cr>", opts)

-- normal split naviation
keymap("n", "<C-h>", t_mv_h, opts)
keymap("n", "<C-j>", t_mv_j, opts)
keymap("n", "<C-k>", t_mv_k, opts)
keymap("n", "<C-l>", t_mv_l, opts)

-- split resizing
keymap("n", "<C-Up>", ":resize +1<cr>", opts)

-- terminal mode naviation
keymap("t", "<Esc>", t_esc, opts)
keymap("t", "<C-h>", t_esc..t_mv_h, opts)
keymap("t", "<C-j>", t_esc..t_mv_j, opts)
keymap("t", "<C-k>", t_esc..t_mv_k, opts)
keymap("t", "<C-l>", t_esc..t_mv_l, opts)
