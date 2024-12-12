require("lazy").setup({
  spec = {
    { "catppuccin/nvim",         name = "catppuccin",                          priority = 1000 },
    { 'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons', opts = {} },
    { 'dracula/vim' },
    {
      "folke/noice.nvim",
      opts = {},
      dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }
    },
    {
      'ibhagwan/fzf-lua',
      opts = {
        files = { fd_opts = "--hidden --type f" }
      }
    },
    {
      'kyazdani42/nvim-tree.lua',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {
        sync_root_with_cwd = true,
        respect_buf_cwd = false,
        view = { adaptive_size = true },
      }
    },
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, opts = {} },
    {
      "williamboman/mason.nvim",           -- Manages LSP servers
      "williamboman/mason-lspconfig.nvim", -- Integrates mason with nvim-lspconfig
      "neovim/nvim-lspconfig",             -- Core LSP client
      "hrsh7th/nvim-cmp",                  -- Minimal autocompletion framework
      "hrsh7th/cmp-nvim-lsp",              -- LSP completions,
      'nvim-tree/nvim-web-devicons',
      'lukas-reineke/headlines.nvim',
      'markonm/traces.vim',
      'mhinz/vim-startify',
      'nvim-orgmode/orgmode',
      'voldikss/vim-floaterm',
    },
    {
      'nvim-treesitter/nvim-treesitter',
      opts = {
        ensure_installed = { "c", "lua", "rust", "typescript", "javascript", "org", "http", "json", "java", "python", "regex", "bash" },
        sync_install = true,
        highlight = { enable = true },
      }
    },
  },
  checker = { enabled = true }
})
