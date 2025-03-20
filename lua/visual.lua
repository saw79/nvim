local colorscheme_default = "default"
--local colorscheme_desired = "sonokai"
--local colorscheme_desired = "oceanicnext"
--local colorscheme_desired = "catppuccin"
--local colorscheme_desired = "nightfox"
--local colorscheme_desired = "carbonfox"
local colorscheme_desired = "kanagawa"

------------------------------------------------------------------------------------------

local colorscheme = colorscheme_desired

local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status then
  vim.notify("WARNING - colorscheme '" .. colorscheme .. "' not found, using default")
  vim.cmd("colorscheme " .. colorscheme_default)
end

-- guibg=#123456 for 24-bit mode
vim.cmd("hi MatchParen ctermbg=240")

------------------------------------------------------------------------------------------

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#7A3A41" })  -- #E06C75
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#8F713E" })  -- #E5C07B
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#315F87" })  -- #61AFEF
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#805A3A" })  -- #D19A66
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#4F6E49" })  -- #98C379
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#713F8A" })  -- #C678DD
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#2E646C" })  -- #56B6C2
end)

require("ibl").setup { indent = { highlight = highlight } }

--require("ibl").setup()
