local opts = { noremap = true, silent = true }

vim.api.nvim_buf_set_keymap(0, "n", "<leader>cc", ":CsvViewToggle<cr>", opts)
