-- tabs/spaces options
vim.opt.tabstop = 2 -- tab size
vim.opt.expandtab = true -- tabs -> spaces
vim.opt.shiftwidth = 2 -- indent size

-- visuals, navigation
vim.opt.termguicolors = false -- might not be available on MacOS
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- popup  menu height (default=0)
--vim.opt.completeopt = { "menu", "menuone", "noselect" }
--vim.opt.pumheight = 10

vim.api.nvim_command("autocmd VimResized * wincmd =")

-- guibg=#123456 for 24-bit mode
vim.cmd("hi MatchParen ctermbg=240")

vim.o.winborder = "rounded"
