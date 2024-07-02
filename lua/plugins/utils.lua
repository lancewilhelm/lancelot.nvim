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
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    event = 'VeryLazy',
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = "~/Documents/Lance's Vault/",
        },
      },
    },
    keys = {
      { '<leader>oo', '<cmd>ObsidianOpen<cr>', '[O]pen note in Obsidian' },
      { '<leader>on', '<cmd>ObsidianNew<cr>', '[N]ew note' },
      { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', 'Note [b]acklinks' },
      { '<leader>ot', '<cmd>ObsidianTemplate<cr>', 'Insert [t]emplate' },
      { '<leader>os', '<cmd>ObsidianSearch<cr>', 'Seach [n]otes' },
      { '<leader>ol', '<cmd>ObsidianLinks<cr>', 'Note [l]inks' },
    },
  },
}
