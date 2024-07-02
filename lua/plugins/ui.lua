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

      local function get_footer()
        local quotes = {
          'gyatt damn',
          'ooo baby a triple',
          'lightweight babay',
          "ain't nutt'n but a peanut",
          'but why male models?',
          'yo xan get your boy dawg',
          'this is fine',
          "not my chair not my problem that's what I always say",
          "shake 'n bake",
        }

        math.randomseed(os.time())
        local random_index = math.random(#quotes)
        local cwd = vim.fn.getcwd()
        return { '', cwd, '', quotes[random_index] }
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
          footer = get_footer(),
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
        command_palette = false, -- position the cmdline and popupmenu together
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
  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    config = function()
      require('colorizer').setup {
        'toml',
        'css',
        'javascript',
        'vue',
        html = {
          mode = 'foreground',
        },
      }
    end,
    keys = {
      { '<leader>uca', '<cmd>ColorizerAttachToBuffer<cr>', desc = 'Attach [c]olorizer to buffer' },
      { '<leader>ucd', '<cmd>ColorizerDetachFromBuffer<cr>', desc = 'Detach [c]olorizer from buffer' },
    },
  },
}
