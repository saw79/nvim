local colorscheme_24b = "sonokai"
local colorscheme_256 = "sonokai"
--local colorscheme_256 = "oceanicnext"
local colorscheme_default = "default"

------------------------------------------------------------------------------------------

local colorscheme = colorscheme_default
if vim.fn.has("gui_vimr") > 0 then
  -- print("Using VimR - enabling 24-bit colorscheme")
  colorscheme = colorscheme_24b
else
  -- print("Using terminal neovim - enabling 256 color colorscheme")
  colorscheme = colorscheme_256
end

local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status then
  vim.notify("WARNING - colorscheme '" .. colorscheme .. "' not found, using default")
  vim.cmd("colorscheme " .. colorscheme_default)
end

-- guibg=#123456 for 24-bit mode
vim.cmd("hi MatchParen ctermbg=240")
