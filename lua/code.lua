local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, silent = true, expr = true }

local save = ":w<cr>"
local to_term = "<C-w>l"
local to_buff = "<C-w>h"
local esc = "<C-\\><C-n>"

-- running code

local function terminal_command(words, is_prompt)
  local str = ""
  for i, word in ipairs(words) do
    if string.sub(word, 1, 1) == "%" then
      word = vim.fn.expand(word)
    end

    if i > 1 then
      str = str .. " "
    end

    str = str .. word
  end
  local cmd = save .. to_term .. "a" .. str

  if is_prompt then
    cmd = cmd .. " "
  else
    cmd = cmd .. "<cr>" .. esc .. to_buff
  end
  return cmd
end

local function keymap(key_str, cmd_str, mode)
  mode = mode or "n"
  vim.api.nvim_set_keymap(mode, key_str, cmd_str, opts)
end

local function set_term_cmd_keymap(key_str, words, is_prompt)
  vim.keymap.set(
    "n",
    key_str,
    function() return terminal_command(words, is_prompt) end,
    expr_opts)
end

-- running code

-- run prev term cmd
keymap("<leader>r.", save .. to_term .. "a<Up>" .. "<cr>" .. esc .. to_buff)
-- run current python file
set_term_cmd_keymap("<leader>rr", {"python", "%:t"})
-- run python terminal
keymap("<leader>rp", save .. to_term .. "apython<cr>")
-- abort current terminal process
keymap("<C-q>", save .. to_term .. "a<C-c>" .. esc .. to_buff)

-- run haskell code
set_term_cmd_keymap("<leader>rh", {"cabal run"})

-- conda environments

set_term_cmd_keymap("<leader>od", {"conda deactivate"})
set_term_cmd_keymap("<leader>oa", {"conda activate"}, true)

-- commenting

keymap("<leader>kk", "I# <Esc>j")
keymap("<leader>jj", "^xxj")

keymap("<leader>kk", "<S-v><C-v>0I# <Esc>", "v")
keymap("<leader>jj", "<Esc>'<0<C-v>'>lx", "v")

-- insert breakpoint

keymap("<leader>do", "obreakpoint()<Esc>")
keymap("<leader>dO", "Obreakpoint()<Esc>")
