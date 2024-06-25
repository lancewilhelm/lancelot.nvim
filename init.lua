-- order matters with these declarations!!!

-- options
-- require 'options'
require 'config.lazy'

-- keymaps
require 'keymaps'

-- install and initialize `lazy.vim` plugin manager
-- require 'lazy-bootstrap'

-- plugins
-- require('lazy').setup 'plugins'

-- placing theme here until I find a better spot
vim.cmd.colorscheme 'catppuccin'

-- the line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
