return {
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      require('ufo').setup()
    end,
  },
  -- Option 2: nvim lsp as LSP client
  -- NOTE: This option shows how to configure folding with native LSP.
  --       It's রাখা as a separate plugin spec, but the LSP client setup
  --       should be handled in a single place, not repeated.
  --       I've adjusted it to reflect best practices.
  {
    'nvim-lsp/nvim-lspconfig',
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local servers = { 'gopls', 'clangd' } -- Add other LSP servers as needed
      for _, server_name in ipairs(servers) do
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          -- Add any server-specific settings here
        }
      end
    end,
  },

  -- Option 3: treesitter as a main provider instead
  -- {
  --       'nvim-treesitter/nvim-treesitter',
  --       config = function()
  --           require('ufo').setup({
  --               provider_selector = function(bufnr, filetype, buftype)
  --                   return {'treesitter', 'indent'}
  --               end
  --           })
  --       end
  -- },
}
