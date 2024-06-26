local colorscheme_default = "default"
--local colorscheme_desired = "sonokai"
--local colorscheme_desired = "oceanicnext"
--local colorscheme_desired = "kanagawa"
--local colorscheme_desired = "catppuccin"
--local colorscheme_desired = "nightfox"
local colorscheme_desired = "carbonfox"

------------------------------------------------------------------------------------------

local colorscheme = colorscheme_desired

local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status then
  vim.notify("WARNING - colorscheme '" .. colorscheme .. "' not found, using default")
  vim.cmd("colorscheme " .. colorscheme_default)
end

-- guibg=#123456 for 24-bit mode
vim.cmd("hi MatchParen ctermbg=240")
