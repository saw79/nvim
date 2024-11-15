local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, silent = true, expr = true }

local save = ":w<cr>"
local to_term = "<C-w>l"
local to_buff = "<C-w>h"
local esc = "<C-\\><C-n>"

--vim.g.term_chan_id = nil

local function create_term_cmd_str(words, requires_input)
  local cmd_str = ""
  for i, word in ipairs(words) do
    if string.sub(word, 1, 1) == "%" then
      word = vim.fn.expand(word)
    end

    if i > 1 then
      cmd_str = cmd_str .. " "
    end

    cmd_str = cmd_str .. word
  end

  -- machinery to save, move split, enter terminal mode
  local full_cmd_str = save .. to_term .. "a" .. cmd_str

  if requires_input then
    full_cmd_str = full_cmd_str .. " "
  else
    full_cmd_str = full_cmd_str .. "<cr>" .. esc .. to_buff
  end
  return full_cmd_str
end

function _G.set_term_cmd_keymap(key_str, words, requires_input)
  vim.keymap.set(
    "n",
    key_str,
    function() return create_term_cmd_str(words, requires_input) end,
    { noremap = true, silent = true, expr = true, buffer = 0 }
    )
end

local function open_terminal()
  vim.cmd("vsp")
  vim.cmd("term")
  --local buf = vim.api.nvim_get_current_buf()
  --vim.g.term_chan_id = buf
  --print("Terminal Channel ID saved as:", vim.g.term_chan_id)
  vim.cmd("setlocal sidescrolloff=0")

  -- go back to left split
  vim.cmd('execute \"normal \\<c-w>h\"')
end

local function start_tensorboard()
  vim.cmd("sp")
  vim.cmd("term")
  vim.cmd('execute \"normal \\<c-w>20-\"')
  --vim.cmd('execute \"normal atensorboard --logdir output/\"')
end

----------------------------- terminal -----------------------------

local function keymap(key_str, cmd_str, mode)
  mode = mode or "n"
  vim.api.nvim_set_keymap(mode, key_str, cmd_str, opts)
end

-- terminal creation/manipulation
-- (see code.lua for sending code)
--keymap("n", "<leader>to", ":vsp<cr>:term<cr>" .. to_buff)
vim.keymap.set("n", "<leader>to", open_terminal, {})
keymap("<leader>tt", to_term .. "a" .. esc .. to_buff)
vim.keymap.set("n", "<leader>tb", start_tensorboard, {})

----------------------------- running code -----------------------------
-------------- CORE --------------
-- run prev term cmd
keymap("<leader>r.", save .. to_term .. "a<Up>" .. "<cr>" .. esc .. to_buff)
-- kill current terminal process
keymap("<C-q>", save .. to_term .. "a<C-c>" .. esc .. to_buff)


-------------- HASKELL --------------
--set_term_cmd_keymap("<leader>rh", {"cabal run"})

-------------- LISP --------------
-- set_term_cmd_keymap("<leader>rl", {"sbcl --script", "%:t"})

-------------- JULIA --------------
-- set_term_cmd_keymap("<leader>rj", {"julia", "%:t"})

-------------- python / black / autocmd --------------
vim.api.nvim_create_augroup("AutoFormat", {})

vim.api.nvim_create_autocmd(
  "BufWritePost",
  {
    pattern = "*.py",
    group = "AutoFormat",
    callback = function()
      vim.cmd("silent !black --quiet %")
      -- vim.cmd("edit")
    end,
  }
)
