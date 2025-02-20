local opts = { noremap = true, silent = true }
local buf_opts = { noremap = true, silent = true, buffer = 0 }

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

-- run current file file
--set_term_cmd_keymap("<leader>rr", {"poetry run", "python", "%:t"})
set_term_cmd_keymap("<leader>rr", {"python", "%:t"})
set_term_cmd_keymap("<leader>ra", {"eval $(poetry env activate)"})

-- python terminal
--keymap("<leader>rp", save .. to_term .. "apoetry run python<cr>")
--set_term_cmd_keymap("<leader>rp", {"poetry run python"})
set_term_cmd_keymap("<leader>rp", {"python"})
--set_term_cmd_keymap("<leader>rs", {"poetry run", "ipython"})
--keymap("<leader>rq", save .. to_term .. "aquit()<cr>")
set_term_cmd_keymap("<leader>rq", {"quit()"})

-- commenting
-- normal
vim.api.nvim_buf_set_keymap(0, "n", "<leader>kk", "I# <Esc>j", opts)
vim.api.nvim_buf_set_keymap(0, "n", "<leader>jj", "^xxj", opts)
-- visual/block
vim.keymap.set("v", "<leader>kk", python_block_comment, buf_opts)
vim.api.nvim_buf_set_keymap(0, "v", "<leader>jj", "^o^<S-v><C-v>lx", opts)

-- insert breakpoint
vim.api.nvim_buf_set_keymap(0, "n", "<leader>do", "obreakpoint()<Esc>", opts)
vim.api.nvim_buf_set_keymap(0, "n", "<leader>dO", "Obreakpoint()<Esc>", opts)

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

-- insert cell delimiters
--vim.api.nvim_buf_set_keymap(0, "n", "<leader>pc", "o# %% <esc>60a-<esc>", opts)
-- run cell
--vim.keymap.set("n", "<leader>rc", python_run_cell, {})
