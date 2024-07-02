local map = vim.keymap.set

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- new file
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- do not yank on paste in visual mode
map('x', 'p', 'P')

-- ctrl + s to save
-- map('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save file' })

-- training wheels: disables arrow keys
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
map('i', '<left>', '<cmd>echo "Use normal mode to move!!"<CR>')
map('i', '<right>', '<cmd>echo "Use normal mode to move!!"<CR>')
map('i', '<up>', '<cmd>echo "Use normal mode to move!!"<CR>')
map('i', '<down>', '<cmd>echo "Use normal mode to move!!"<CR>')

-- display line movement rather than logical lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- diagnostic keymaps
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open line [d]iagnotics' })
map('n', '[d', diagnostic_goto(false), { desc = 'Go to previous [d]iagnostic message' })
map('n', ']d', diagnostic_goto(true), { desc = 'Go to next [d]iagnostic message' })
-- map('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
-- map('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix List' })

-- lazy
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Open [L]azy' })

-- dashboard
-- map('n', '<leader>ud', '<cmd>Dashboard<cr>', { desc = 'Opens the [d]ashboard' })

-- window movements & actions
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<leader>ww', '<C-w>p', { desc = 'Switch to other [w]indow' })
map('n', '<leader>wd', '<C-w>c', { desc = '[D]elete window' })
map('n', '<leader>ws', '<C-w>s', { desc = '[S]plit window below' })
map('n', '<leader>wv', '<C-w>v', { desc = '[S]plit window right' })

-- buffers
-- map('n', '<leader>bd', '<cmd>bd<cr>', { desc = '[D]elete current [b]uffer and window' })
map('n', '<leader>bd', require('utils').bufremove, { desc = '[D]elete current [b]uffer' })
map('n', '<A-h>', '<cmd>bprevious<cr>', { desc = 'Goto previous [b]uffer' })
map('n', '<A-l>', '<cmd>bnext<cr>', { desc = 'Goto next [b]uffer' })
map('n', '<A-S-h>', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move [b]uffer left' })
map('n', '<A-S-l>', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move [b]uffer right' })

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = '[Q]uit all' })

-- move lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- commenting
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- terminal stuff I plan to never use because why use the terminal in here?
map('t', '<esc><esc>', '<C-\\><C-n>', { desc = 'Enter normal mode' })
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide terminal' })

-- toggles
map('n', '<leader>ud', require('utils').diagnostics, { desc = 'Toggle [d]iagnotics' })
map('n', '<leader>uw', function()
  require('utils').toggle_option 'wrap'
end, { desc = 'Toggle Word [W]rap' })
map('n', '<leader>us', function()
  require('utils').toggle_option 'spell'
end, { desc = 'Toggle [S]pelling' })
map('n', '<leader>uL', function()
  require('utils').toggle_option 'relativenumber'
end, { desc = 'Toggle relative [l]ine numbers' })
map('n', '<leader>ul', require('utils').number, { desc = 'Toggle [l]ine numbers' })
map('n', '<leader>uT', function()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
  else
    vim.treesitter.start()
  end
end, { desc = 'Toggle Treesitter Highlight' })

-- [[ Autocommands ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.g.disable_autoformat = false
vim.b.disable_autoformat = false
vim.api.nvim_create_user_command('FormatToggle', function(args)
  if args.bang then
    local disable_autoformat = vim.g.disable_autoformat
    disable_autoformat = not disable_autoformat
    if disable_autoformat then
      vim.g.disable_autoformat = true
      require('noice').notify('Global formatting on save disabled', 'warn', { title = 'Formatting' })
    else
      vim.g.disable_autoformat = false
      require('noice').notify('Global formatting on save enabled', 'info', { title = 'Formatting' })
    end
  else
    local disable_autoformat = vim.b.disable_autoformat
    disable_autoformat = not disable_autoformat
    if disable_autoformat then
      vim.b.disable_autoformat = true
      require('noice').notify('Buffer formatting on save disabled', 'warn', { title = 'Formatting' })
    else
      vim.b.disable_autoformat = false
      require('noice').notify('Buffer formatting on save enabled', 'info', { title = 'Formatting' })
    end
  end
end, {
  desc = 'Toggle autoformat-on-save',
  bang = true,
})
