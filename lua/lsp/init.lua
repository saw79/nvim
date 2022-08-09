local status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify("ERROR - could not load lspconfig")
  return
end

local settings = require("lsp.settings")

local function on_attach(_, bufnr)
  settings.set_lsp_keymaps(bufnr)
  --settings.set_highlighting(client)
end

lspconfig["sumneko_lua"].setup{
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "fallback" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}

--[[
lspconfig["pyright"].setup{
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoImportCompletions = false,
      }
    }
  }
}
--]]

lspconfig["pylsp"].setup{
  on_attach = on_attach,
}

settings.set_options()
