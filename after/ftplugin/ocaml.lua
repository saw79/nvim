local opts = { noremap = true, silent = true }

-- run current file file
set_term_cmd_keymap("<leader>rr", {"dune exec qc_oc"})

-- commenting
vim.api.nvim_buf_set_keymap(0, "n", "<leader>kk", "I-- <Esc>j", opts)
vim.api.nvim_buf_set_keymap(0, "n", "<leader>jj", "^xxxj", opts)
