return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Open lazy[g]it' },
      { '<leader>gC', '<cmd>LazyGitFilter<cr>', desc = 'View buffer [c]ommits' },
      { '<leader>gc', '<cmd>LazyGitFilterCurrentFile<cr>', desc = 'View project [c]ommits' },
    },
  },
}
