-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- [[ Options ]]
require 'options'

-- [[ Keymaps ]]
require 'keymaps'

-- [[ Install and initialize `lazy.vim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Plugins ]]
require 'plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
