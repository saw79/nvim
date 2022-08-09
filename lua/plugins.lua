-- Automatically install packer

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print("Installing packer close and reopen Neovim...")
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use

local status, packer = pcall(require, "packer")
if not status then
  -- vim.notify
  print("ERROR - Cannot import packer!")
  return
end

-- Have packer use a popup window

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Specify plugins

return packer.startup(function(use)
  -- My plugins here
  -- use "user/repo"
  -- or use { "user/repo", option1 = value1, option2 = value2, }

  use "wbthomason/packer.nvim"
  -- use "nvim-lua/popup.nvim"
  -- use "nvim-lua/plenary.nvim"

  -- colorschemes
  use "mhartington/oceanic-next"
  use "sainnhe/sonokai"

  -- cmp plugins
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lsp"
  use "L3MON4D3/LuaSnip"

  -- LSP
  use "neovim/nvim-lspconfig"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
