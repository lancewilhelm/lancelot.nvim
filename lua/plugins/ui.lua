return {
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss All Notifications',
      },
    },
    opts = {},
    init = function()
      vim.notify = require 'notify'
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    'nvimdev/dashboard-nvim',
    lazy = false,
    config = function()
      local function generate_header()
        local logo = [[
                                         *                                      
            *               *                         *                 *       
  *                *               *            *          *    *               
     *   ▄▄▄     ▄▄▄▄▄▄▄ ▄▄    ▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄     ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄   *    
        █   █   █       █  █  █ █       █       █   █   █       █       █       
  *     █   █   █   ▄   █   █▄█ █       █    ▄▄▄█   █   █   ▄   █▄     ▄█       
        █   █   █  █▄█  █       █     ▄▄█   █▄▄▄█   █   █  █ █  █ █   █   *     
        █   █▄▄▄█       █  ▄    █    █  █    ▄▄▄█   █▄▄▄█  █▄█  █ █   █         
     *  █       █   ▄   █ █ █   █    █▄▄█   █▄▄▄█       █       █ █   █     *   
        █▄▄▄▄▄▄▄█▄▄█ █▄▄█▄█  █▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█ █▄▄▄█         
   *                          *                          *             *        
       *    *                        *            *               *             
                  *      *                 *               *                    
        ]]

        -- logo = string.rep('\n', 2) .. logo .. '\n\n'

        return vim.split(logo, '\n')
      end

      local function get_random_quote()
        local quotes = {
          'gyatt damn',
          'ooo baby a triple',
          'les getit',
          'lightweight babay',
          "ain't nutt'n but a peanut",
        }

        math.randomseed(os.time())
        local random_index = math.random(#quotes)
        return { '', '', quotes[random_index] }
      end

      require('dashboard').setup {
        config = {
          header = generate_header(),
          shortcut = {
            {
              desc = ' files',
              key = 'f',
              action = function()
                require('telescope.builtin').find_files()
              end,
            },
            {
              desc = ' new',
              key = 'n',
              action = 'ene | startinsert',
            },
            {
              desc = ' recent',
              key = 'r',
              action = function()
                require('telescope.builtin').oldfiles()
              end,
            },
            {
              desc = '󱎸 text',
              key = 't',
              action = function()
                require('telescope.builtin').live_grep()
              end,
            },
            {
              desc = ' conf',
              key = 'c',
              action = function()
                require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
              end,
            },
            {
              desc = '󰩈 exit',
              key = 'q',
              action = function()
                vim.api.nvim_input '<cmd>qa<cr>'
              end,
            },
          },
          hide = {
            statusline = true,
            tabline = false,
          },
          footer = get_random_quote(),
        },
      }
    end,
    requires = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
    main = 'ibl',
  },
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        pickers = {
          buffers = {
            mappings = {
              i = {
                ['<C-q>'] = require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top,
              },
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'notify')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sn', '<cmd>Telescope notify<cr>', { desc = '[S]earch [n]otifications' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sc', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch neovim [c]onfig' })
    end,
  },
  {
    'rcarriga/nvim-notify',
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      theme = 'auto',
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',
    opts = {
      options = {
        always_show_bufferline = false,
        diagnostics = 'nvim_lsp',
        separator_style = 'slant',
        numbers = function(opts)
          return string.format('%s', opts.raise(opts.ordinal))
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
    keys = {
      { '<leader>1', "<cmd>lua require('bufferline').go_to(1, true)<cr>", desc = 'Goto bufferline 1' },
      { '<leader>2', "<cmd>lua require('bufferline').go_to(2, true)<cr>", desc = 'Goto bufferline 2' },
      { '<leader>3', "<cmd>lua require('bufferline').go_to(3, true)<cr>", desc = 'Goto eufferline 3' },
      { '<leader>4', "<cmd>lua require('bufferline').go_to(4, true)<cr>", desc = 'Goto eufferline 4' },
      { '<leader>5', "<cmd>lua require('bufferline').go_to(5, true)<cr>", desc = 'Goto eufferline 5' },
      { '<leader>6', "<cmd>lua require('bufferline').go_to(6, true)<cr>", desc = 'Goto eufferline 6' },
      { '<leader>7', "<cmd>lua require('bufferline').go_to(7, true)<cr>", desc = 'Goto eufferline 7' },
      { '<leader>8', "<cmd>lua require('bufferline').go_to(8, true)<cr>", desc = 'Goto eufferline 8' },
      { '<leader>9', "<cmd>lua require('bufferline').go_to(9, true)<cr>", desc = 'Goto eufferline 9' },
    },
  },
}
