M = {}

function M.set_lsp_keymaps(bufnr)
  local buff_opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, buff_opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, buff_opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, buff_opts)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, buff_opts)

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buff_opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, buff_opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, buff_opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, buff_opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, buff_opts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, buff_opts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, buff_opts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, buff_opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, buff_opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, buff_opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, buff_opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, buff_opts)
  --vim.keymap.set("n", "gl", function() vim.diagnostic.show_line_diagnostics({ border = 'rounded' }) end, buff_opts)
  vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float, buff_opts)
  --vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, buff_opts)
  --vim.keymap.set("n", "]d", vim.diagnostic.goto_next, buff_opts)
  --vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", buff_opts)
  --vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

function M.set_highlighting(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

function M.set_options()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
