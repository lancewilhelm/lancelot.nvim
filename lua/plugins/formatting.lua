return {
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
      { '<leader>uf', '<cmd>FormatToggle<cr>', desc = 'Toggle auto[f]ormat-on-save (buffer)' },
      { '<leader>uF', '<cmd>FormatToggle!<cr>', desc = 'Toggle auto[f]ormat-on-save (global)' },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- local disable_filetypes = { c = true, cpp = true }
        -- return {
        --   timeout_ms = 500,
        --   lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        -- }
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        javascript = { { 'prettierd', 'prettier' } },
      },
    },
  },
}
