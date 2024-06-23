local map = vim.keymap.set

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- new file
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- training wheels: disables arrow keys
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

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

-- explorer stuff
map('n', '<leader>fE', '<cmd>Explore<cr>', { desc = 'Open Netrw [f]ile [e]plorer' })

-- lazy
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Open [L]azy' })

-- dashboard
map('n', '<leader>ud', '<cmd>Dashboard<cr>', { desc = 'Opens the [d]ashboard' })

-- window movements & actions
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<leader>ww', '<C-w>p', { desc = 'Switch to other [w]indow' })
map('n', '<leader>wd', '<C-w>c', { desc = '[D]elete window' })
map('n', '<leader>ws', '<C-w>s', { desc = '[S]plit window below' })
map('n', '<leader>wv', '<C-w>v', { desc = '[S]plit window right' })

-- buffers
map('n', '<leader>bd', '<cmd>bd<cr>', { desc = '[D]elete current [b]uffer and window' })

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = '[Q]uit all' })

-- move lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- terminal stuff I plan to never use because why use the terminal in here?
map('t', '<esc><esc>', '<C-\\><C-n>', { desc = 'Enter normal mode' })
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide terminal' })

-- [[ Autocommands ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
