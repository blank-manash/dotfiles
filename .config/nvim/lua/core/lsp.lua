-- Mason setup
require("mason").setup()

local servers = { "lua_ls", "pyright", "rust_analyzer", "clangd" }
-- Automatically install LSP servers
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- LSP setup
local lspconfig = require("lspconfig")

-- Attach LSP keybindings
local on_attach = function(_, bufnr)
  local buf_map = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }

  buf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_map(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_map(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
end

-- LSP servers
for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  })
end
