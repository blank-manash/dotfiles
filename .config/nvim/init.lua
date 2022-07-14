local function settings(vim)
  vim.o.tabstop = 4
  vim.g.mapleader = ','
  vim.opt.cmdheight = 1
  vim.opt.showcmd = true
  vim.opt.number = true
  vim.opt.hlsearch = true
  vim.opt.hidden = true
  vim.opt.smartcase = true
  vim.g.noerrorbells = true
  vim.opt.background = 'dark'
  vim.opt.belloff = 'esc'
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.g.nowrap = true
  vim.g.noswapfile = true
  vim.opt.mouse = 'a'
  vim.opt.termguicolors = true
  vim.opt.splitright = true
  vim.opt.splitbelow = true
  vim.opt.autoindent = true
  vim.opt.path = vim.opt.path + { '**' }
  vim.opt.wildmenu = true
  vim.g.termwinsize = 14 * 0
  vim.opt.conceallevel = 2
  vim.opt.concealcursor = 'nc'
  --vim.cmd('set wildmode=longest:full,full')
  vim.cmd('set foldmethod=expr')
  vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
  --
  vim.cmd('color moonfly')
  vim.cmd('let &guifont="Dank Mono:h12"')
  vim.cmd('autocmd BufWritePost ~/.config/nvim/init.lua source %')
end

local function mappings(vim)
  vim.cmd('inoremap jk <Esc>')
  vim.cmd('nnoremap <Leader>nt :NvimTreeToggle<CR>')
  vim.cmd('nnoremap <Leader>ff :Telescope find_files<CR>')
  vim.cmd('nnoremap <Leader>fb :Telescope buffers<CR>')
  vim.cmd('nnoremap <Leader>fr :Telescope oldfiles<CR>')
  vim.cmd('nnoremap <Leader>fh :Telescope help_tags<CR>')
  vim.cmd('nnoremap <Leader>fc :Telescope colorscheme<CR>')
  vim.cmd('nnoremap <Leader>fs :Telescope spell_suggest<CR>')
  vim.cmd('nnoremap <Leader>fm :Telescope keymaps<CR>')
  vim.cmd('nnoremap <C-s> :Telescope current_buffer_fuzzy_find<CR>')
  vim.cmd('nnoremap <F8> :Vista coc<CR>')
  vim.cmd('nnoremap <Leader>pin :PackerSync<CR>')
  vim.cmd('nnoremap <Leader>vrc :edit ~/.vimrc<CR>')
  vim.cmd('nnoremap <A-f> :Format<CR>')
  vim.cmd('nnoremap <A-b> :w <bar> %bd <bar> e# <bar> bd# <CR><CR>')
  vim.cmd('nnoremap ,sp "+p')
  vim.cmd('inoremap jk <Esc>')
  vim.cmd('nnoremap <Leader>ts :TestSuite<CR>')
  vim.cmd('nnoremap <Leader>tl :TestLast<CR>')
  vim.cmd('nnoremap <Leader>tt :TestNearest<CR>')
end

local function setupTerminal()
  vim.cmd('source ~/.vim/terminal-setup.vim')
end

local function cocSetup()
  vim.cmd('source ~/.vim/coc-source.vim')
end

settings(vim)
mappings(vim)
setupTerminal()
cocSetup()

require('packer').startup(function(use)
  use { 'bluz71/vim-moonfly-colors',
    'wbthomason/packer.nvim',

    'tpope/vim-dispatch',
    'tpope/vim-fugitive',
    -- 'vimwiki/vimwiki',
    -- 'ctrlpvim/ctrlp.vim',
    'liuchengxu/vista.vim',
    'itchyny/calendar.vim',
    'dhruvasagar/vim-dotoo',
    'ryanoasis/vim-devicons',
    'markonm/traces.vim',
    'akinsho/org-bullets.nvim',
    'alpertuna/vim-header',
    -- 'gpanders/vim-medieval',
    'cseelus/vim-colors-lucid',
    'tpope/vim-surround',
    'gelguy/wilder.nvim',
    'searleser97/cpbooster.vim',
    'mboughaba/i3config.vim',
    'mhinz/vim-startify',
    -- 'pbogut/fzf-mru.vim',
    -- 'ibhagwan/fzf-lua',
    -- 'junegunn/fzf',
    'vifm/vifm.vim',
    'sheerun/vim-polyglot',
    'vim-test/vim-test',
    'dracula/vim',
    'kkoomen/vim-doge',
    'shaeinst/roshnivim-cs',
    'nvim-orgmode/orgmode',
    'lukas-reineke/headlines.nvim',
    -- Telescope Plugins
    'nvim-telescope/telescope-project.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- using packer.nvim
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' }
  use { 'neoclide/coc.nvim', branch = 'release' }
end)

local function treesitterSetup()
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "typescript", "javascript", "org", "norg" },
    sync_install = true,
    highlight = {
      enable = true,
    },
  }
end

local function orgModeSetup()
  local org = require('orgmode')
  org.setup_ts_grammar()

  require('org-bullets').setup {
    headlines = { "◉", "○", "✸", "✿" },
  }
  org.setup({
    org_agenda_files = { '~/gtd/*', '~/notes/**/*' },
    org_default_notes_file = '~/Dropbox/org/refile.org',
  })
end

local function wilderSetup()
  local wilder = require('wilder')
  wilder.setup({
    modes = { ':', '/', '?' },
    next_key = '<C-n>',
    previous_key = '<C-p',
    accept_key = '<C-j>',
    reject_key = '<C-k>'
  })
end

local function telescopeSetup()
  local ts = require('telescope')
  local actions = require('telescope.actions')
  ts.setup {
    pickers = {
      find_files = {
        hidden = true
      }
    },
    extensions = {
      project = {
        base_dirs = { '/home/manash/Projects/' }
      }
    },
    mappings = {
      n = {
        ["q"] = actions.close
      },
      i = {
        ["<C-j>"] = {
          action = actions.move_selection_next,
          opts = { nowait = true, silent = true }

        },
        ["<C-k>"] = {
          action = actions.move_selection_previous,
          opts = { nowait = true, silent = true }
        }
      }
    }
  }
  ts.load_extension('fzf')
  ts.load_extension('project')
end

local function setups()
  require("bufferline").setup { diagnostics = "coc" }
  require('lualine').setup {}
  require('nvim-tree').setup { sync_root_with_cwd = true, respect_buf_cwd = false, view = { adaptive_size = true } }
  telescopeSetup()
  orgModeSetup()
  treesitterSetup()
  wilderSetup()
end

setups()
