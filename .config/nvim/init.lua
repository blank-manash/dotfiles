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
  vim.cmd('set wildmode=longest:full,full')
  vim.cmd('color moonfly')
  vim.cmd('let &guifont="Dank Mono:h12"')
  vim.cmd('autocmd BufWritePost ~/.config/nvim/init.lua source %')
end

local function mappings(vim)
  vim.cmd('inoremap jk <Esc>')
  vim.cmd('nnoremap <Leader>fi :Files<CR>')
  vim.cmd('nnoremap <Leader>nt :NvimTreeToggle<CR>')
  vim.cmd('nnoremap <Leader>fi :Files<CR>')
  vim.cmd('nnoremap <Leader>mr :FZFMru<CR>')
  vim.cmd('nnoremap <F8> :Vista coc<CR>')
  vim.cmd('nnoremap <Leader>bu :Buffers<CR>')
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
    'vimwiki/vimwiki',
    'ctrlpvim/ctrlp.vim',
    'liuchengxu/vista.vim',
    'itchyny/calendar.vim',
    'dhruvasagar/vim-dotoo',
    'ryanoasis/vim-devicons',
    'markonm/traces.vim',
    'alpertuna/vim-header',
    'gpanders/vim-medieval',
    'cseelus/vim-colors-lucid',
    'tpope/vim-surround',
    'searleser97/cpbooster.vim',
    'mboughaba/i3config.vim',
    'pbogut/fzf-mru.vim',
    'mhinz/vim-startify',
    'junegunn/fzf.vim',
    'junegunn/fzf',
    'vifm/vifm.vim',
    'sheerun/vim-polyglot',
    'vim-test/vim-test',
    'dracula/vim',
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
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
    ensure_installed = { "c", "lua", "rust", "typescript", "javascript" },
    sync_install = true,
    highlight = {
      enable = true,
    },
  }
end

require("bufferline").setup {
  diagnostics = "coc"
}
require('lualine').setup {}
require('nvim-tree').setup {
  sync_root_with_cwd = true,
  respect_buf_cwd = false,
  view = { adaptive_size = true }
}

treesitterSetup()
