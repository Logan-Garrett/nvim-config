-- Neovim config with C# support and semantic highlighting

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Color scheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- LSP
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      vim.treesitter.language.add("c_sharp")
      vim.treesitter.language.add("lua")
      vim.treesitter.language.add("rust")
      vim.treesitter.language.add("vim")
    end,
  },

  -- Optional: better LSP UI
  "folke/trouble.nvim",
})

-- Color scheme
vim.cmd.colorscheme("catppuccin-mocha")

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "omnisharp" },
})

-- LSP Setup with semantic highlighting
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- OmniSharp for C#
vim.lsp.config("omnisharp", {
  capabilities = capabilities,
  settings = {
    omnisharp = {
      enable_roslyn_analyzers = true,
      enable_editorconfig_support = true,
    }
  }
})

vim.lsp.enable("omnisharp")

-- Enable semantic tokens
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.supports_method("textDocument/semanticTokens/full") then
      vim.lsp.semantic_tokens.start(args.buf, args.data.client_id)
    end
  end,
})

-- Completion setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})

-- Keybindings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true })
