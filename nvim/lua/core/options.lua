local opt = vim.opt
local g = vim.g

opt.tabstop = 4
opt.cmdheight = 1
opt.showcmd = true
opt.number = true
opt.hlsearch = true
opt.hidden = true
opt.smartcase = true
opt.background = 'dark'
opt.belloff = 'esc'
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.mouse = 'a'
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
opt.autoindent = true
opt.path:append('**')
opt.wildmenu = true
opt.conceallevel = 2
opt.concealcursor = 'nc'

g.mapleader = ','
g.noerrorbells = true
g.nowrap = true
g.noswapfile = true
g.termwinsize = 14 * 0

-- Custom commands
vim.cmd('set foldmethod=expr')
vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
vim.cmd('let &guifont="InconsolataGo Nerd Font Mono:h20"')
