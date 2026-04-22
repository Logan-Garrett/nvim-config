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
      vim.treesitter.language.add("python")
      vim.treesitter.language.add("typescript")
      vim.treesitter.language.add("javascript")
      vim.treesitter.language.add("go")
      vim.treesitter.language.add("ocaml")
      vim.treesitter.language.add("scala")
      vim.treesitter.language.add("c")
      vim.treesitter.language.add("cpp")
      vim.treesitter.language.add("java")
      vim.treesitter.language.add("zig")
      vim.treesitter.language.add("bash")
      vim.treesitter.language.add("html")
      vim.treesitter.language.add("css")
      vim.treesitter.language.add("json")
      vim.treesitter.language.add("yaml")
      vim.treesitter.language.add("toml")
      vim.treesitter.language.add("dockerfile")
      vim.treesitter.language.add("markdown")
    end,
  },

  -- ThePrimeagen's tools
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "mbbill/undotree",
  "tpope/vim-fugitive",

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
  ensure_installed = {
    "omnisharp",
    "lua_ls",
    "rust_analyzer",
    "pyright",
    "ts_ls",
    "gopls",
    "ocamllsp",
    "metals",
    "clangd",
    "jdtls",
    "zls",
  },
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

-- Lua
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    }
  }
})

-- Rust
vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
})

-- Python
vim.lsp.config("pyright", {
  capabilities = capabilities,
})

-- TypeScript / JavaScript
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})

-- Go
vim.lsp.config("gopls", {
  capabilities = capabilities,
})

-- OCaml
vim.lsp.config("ocamllsp", {
  capabilities = capabilities,
})

-- Scala
vim.lsp.config("metals", {
  capabilities = capabilities,
})

-- C / C++
vim.lsp.config("clangd", {
  capabilities = capabilities,
})

-- Java
vim.lsp.config("jdtls", {
  capabilities = capabilities,
})

-- Zig
vim.lsp.config("zls", {
  capabilities = capabilities,
})

vim.lsp.enable({
  "omnisharp", "lua_ls", "rust_analyzer", "pyright", "ts_ls", "gopls",
  "ocamllsp", "metals", "clangd", "jdtls", "zls",
})

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

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
