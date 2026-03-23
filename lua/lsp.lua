vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float)

vim.lsp.config("*", {
  root_markers = { ".git" },
})

vim.lsp.config("luals", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
    }
  }
})

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
  settings = {
    python = {
      analysis = {
        autoImportCompletions = false,
        --diagnosticMode = "workspace",
        typeCheckingMode = "off",
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
})

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
  settings = {
  }
})

vim.lsp.config("rust-analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
})

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "cpp" },
})

vim.lsp.enable({
  "luals",
  "pyright",
  "ruff",
  "rust-analyzer",
  "clangd",
})
