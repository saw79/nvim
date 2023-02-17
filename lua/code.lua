local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, silent = true, expr = true }

local save = ":w<cr>"
local to_term = "<C-w>l"
local to_buff = "<C-w>h"
local esc = "<C-\\><C-n>"

vim.g.term_chan_id = nil

local function keymap(key_str, cmd_str, mode)
  mode = mode or "n"
  vim.api.nvim_set_keymap(mode, key_str, cmd_str, opts)
end

-- running code

local function terminal_command(words, requires_input)
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

  if requires_input then
    cmd = cmd .. " "
  else
    cmd = cmd .. "<cr>" .. esc .. to_buff
  end
  return cmd
end

local function set_term_cmd_keymap(key_str, words, requires_input)
  vim.keymap.set(
    "n",
    key_str,
    function() return terminal_command(words, requires_input) end,
    expr_opts)
end

local function open_terminal()
  vim.cmd("vsp")
  vim.cmd("term")
  local buf = vim.api.nvim_get_current_buf()
  vim.g.term_chan_id = buf
  print("Terminal Channel ID saved as:", vim.g.term_chan_id)

  vim.cmd('execute \"normal \\<c-w>h\"')
end

local function python_block_comment()
  -- get cursor positions at beginning and end of selection
  local r0, c0 = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd('execute \"normal o\"')
  local r1, c1 = unpack(vim.api.nvim_win_get_cursor(0))

  if r1 < r0 then
    r0, r1 = r1, r0
    c0, c1 = c1, c0
  end
  vim.cmd('execute \"normal \\<esc>\"')

  -- we need to compute the minimum column over the whole line range
  local c_min = 100
  for r = r0, r1, 1 do
    vim.api.nvim_win_set_cursor(0, {r, 0})
    vim.cmd('execute \"normal w\"')
    local c_curr = vim.api.nvim_win_get_cursor(0)[2]
    if c_curr < c_min then
      c_min = c_curr
    end
  end

  -- now execute block selection over (r0, c_min) -> (r1, c_min)
  vim.api.nvim_win_set_cursor(0, {r0, c_min})
  vim.cmd('execute \"normal \\<c-v>\"')
  vim.api.nvim_win_set_cursor(0, {r1, c_min})

  -- insert #'s
  vim.cmd('execute \"normal I# \\<esc>\"')
end

local function is_line_cell_delimiter(line)
  return line:sub(1, 4) == "# %%"
end

local function get_cell_text()
  local r_cursor, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  if is_line_cell_delimiter(lines[r_cursor]) then
    return nil
  end

  local del0 = 1
  local del1 = #lines

  for r = r_cursor-1, 1, -1 do
    if is_line_cell_delimiter(lines[r]) then
      del0 = r + 1
      break
    end
  end

  for r = r_cursor+1, #lines, 1 do
    if is_line_cell_delimiter(lines[r]) then
      del1 = r - 1
      break
    end
  end

  local cell_text = table.concat(lines, "\n", del0, del1)
  return cell_text
end

local function python_run_cell()
  local text = get_cell_text()
  if text == nil then
    return
  end

  vim.fn.setreg("+", text)

  print("using", vim.g.term_chan_id)
  vim.api.nvim_chan_send(vim.g.term_chan_id, "%paste\n")
end

----------------------------- terminal -----------------------------

-- terminal creation/manipulation
-- (see code.lua for sending code)
--keymap("n", "<leader>to", ":vsp<cr>:term<cr>" .. to_buff)
vim.keymap.set("n", "<leader>to", open_terminal, {})
keymap("<leader>tt", to_term .. "a" .. esc .. to_buff)

----------------------------- running code -----------------------------
-------------- CORE --------------
-- run prev term cmd
keymap("<leader>r.", save .. to_term .. "a<Up>" .. "<cr>" .. esc .. to_buff)
-- kill current terminal process
keymap("<C-q>", save .. to_term .. "a<C-c>" .. esc .. to_buff)

-------------- PYTHON --------------
-- run current file file
set_term_cmd_keymap("<leader>rr", {"python", "%:t"})

-- start python terminal
keymap("<leader>rp", save .. to_term .. "apython<cr>")

-- quit python terminal
--keymap("<leader>rq", save .. to_term .. "aquit()<cr>")
set_term_cmd_keymap("<leader>rs", {"ipython"})
set_term_cmd_keymap("<leader>rq", {"quit()"})

-- insert cell delimiters
keymap("<leader>pc", "o# %% <esc>60a-<esc>")

-- run cell
vim.keymap.set("n", "<leader>rc", python_run_cell, {})

-- conda environments
set_term_cmd_keymap("<leader>od", {"conda deactivate"})
set_term_cmd_keymap("<leader>oa", {"conda activate"}, true)

-- commenting
keymap("<leader>kk", "I# <Esc>j")
keymap("<leader>jj", "^xxj")
vim.keymap.set("v", "<leader>kk", python_block_comment, {})
keymap("<leader>jj", "^o^<S-v><C-v>lx", "v")

-- insert breakpoint
keymap("<leader>do", "obreakpoint()<Esc>")
keymap("<leader>dO", "Obreakpoint()<Esc>")

-------------- HASKELL --------------
set_term_cmd_keymap("<leader>rh", {"cabal run"})

-------------- LISP --------------
set_term_cmd_keymap("<leader>rl", {"sbcl --script", "%:t"})

-------------- JULIA --------------
set_term_cmd_keymap("<leader>rj", {"julia", "%:t"})

-------------- MARKDOWN --------------
keymap("<leader>rm", ":MarkdownPreview<cr>")
