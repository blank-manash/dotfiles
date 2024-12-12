local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('i', 'jk', '<Esc>', opts)
map('n', '<Leader>nt', ':NvimTreeToggle<CR>', opts)
map('n', '<Leader>ff', ':FzfLua files<CR>', opts)
map('n', '<Leader>fb', ':FzfLua buffers<CR>', opts)
map('n', '<Leader>fr', ':FzfLua oldfiles<CR>', opts)
map('n', '<Leader>fc', ':FzfLua colorschemes<CR>', opts)
map('n', '<Leader>ft', ':Telescope', opts)
map('n', '<C-s>', ':FzfLua grep_curbuf<CR>', opts)
map('n', '<A-f>', ':Format<CR>', opts)
map('n', '<A-b>', ':w <bar> %bd <bar> e# <bar> bd# <CR><CR>', opts)

-- Terminal mappings
map('n', '<M-t>', '<Esc>:FloatermToggle<CR>', opts)
map('n', '<A-t>', '<Esc>:FloatermToggle<CR>', opts)
map('t', '<Esc>', '<C-\\><C-n>', opts)
map('t', '<A-t>', '<C-\\><C-n>:FloatermToggle<CR>', opts)
map('t', ':q!', '<C-\\><C-n>:q!<CR>', opts)
