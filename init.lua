-- Neovim config with multi-language LSP, ThePrimeagen tools, and more

-- Leader key (must be set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "mbbill/undotree",
  "tpope/vim-fugitive",

  -- Treesitter context (sticky function headers)
  "nvim-treesitter/nvim-treesitter-context",

  -- Commenting
  "numToStr/Comment.nvim",

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Statusline
  "nvim-lualine/lualine.nvim",

  -- ThePrimeagen extras
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
  },
  {
    "folke/zen-mode.nvim",
    opts = { window = { width = 90 } },
  },

  -- TJ DeVries picks
  "stevearc/oil.nvim",
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },

  -- Folke picks
  "folke/which-key.nvim",
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
  },

  -- Community staples
  "lewis6991/gitsigns.nvim",
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  "stevearc/dressing.nvim",

  -- Better LSP UI
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
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.undofile = true

-- Prime's remaps

-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search (centered)" })

-- J keeps cursor in place
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (cursor stays)" })

-- Paste over selection without losing register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without losing register" })

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- Delete to void register (don't pollute yank)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void" })

-- Disable Q (accidental ex mode)
vim.keymap.set("n", "Q", "<nop>")

-- Quick replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Treesitter context
require("treesitter-context").setup({
  max_lines = 5,
})

-- Comment.nvim
require("Comment").setup()

-- Lualine
require("lualine").setup({
  options = {
    theme = "catppuccin",
    icons_enabled = false,
  },
})

-- Oil (file explorer as buffer)
require("oil").setup()

-- Conform (auto-formatting)
require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    java = { "clang-format" },
    ocaml = { "ocamlformat" },
    scala = { "scalafmt" },
    zig = { "zigfmt" },
    sh = { "shfmt" },
    bash = { "shfmt" },
  },
})

-- Gitsigns
require("gitsigns").setup()

-- Which-key
require("which-key").setup()

-- Noice
require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
  },
})

-- DAP UI
require("dapui").setup()

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
    "bashls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
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

-- Bash
vim.lsp.config("bashls", {
  capabilities = capabilities,
})

-- HTML
vim.lsp.config("html", {
  capabilities = capabilities,
})

-- CSS
vim.lsp.config("cssls", {
  capabilities = capabilities,
})

-- JSON
vim.lsp.config("jsonls", {
  capabilities = capabilities,
})

-- YAML
vim.lsp.config("yamlls", {
  capabilities = capabilities,
})

vim.lsp.enable({
  "omnisharp", "lua_ls", "rust_analyzer", "pyright", "ts_ls", "gopls",
  "ocamllsp", "metals", "clangd", "jdtls", "zls",
  "bashls", "html", "cssls", "jsonls", "yamlls",
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
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(4) end)

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Zen mode
vim.keymap.set("n", "<leader>zz", "<CMD>ZenMode<CR>", { desc = "Zen mode" })

-- Flash
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- Refactoring (lazy-loaded)
local refactoring_loaded = false
local function ensure_refactoring()
  if not refactoring_loaded then
    require("refactoring").setup()
    refactoring_loaded = true
  end
end
vim.keymap.set("x", "<leader>re", function() ensure_refactoring(); require("refactoring").refactor("Extract Function") end, { desc = "Extract function" })
vim.keymap.set("x", "<leader>rv", function() ensure_refactoring(); require("refactoring").refactor("Extract Variable") end, { desc = "Extract variable" })
vim.keymap.set("n", "<leader>ri", function() ensure_refactoring(); require("refactoring").refactor("Inline Variable") end, { desc = "Inline variable" })

-- Gitsigns
vim.keymap.set("n", "]h", function() require("gitsigns").next_hunk() end, { desc = "Next hunk" })
vim.keymap.set("n", "[h", function() require("gitsigns").prev_hunk() end, { desc = "Prev hunk" })
vim.keymap.set("n", "<leader>hp", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", function() require("gitsigns").blame_line() end, { desc = "Blame line" })

-- DAP (debugger)
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Debug continue" })
vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step over" })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step into" })
vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })

-- Trouble (diagnostics)
vim.keymap.set("n", "<leader>xx", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>xd", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics" })

-- Todo comments
vim.keymap.set("n", "<leader>xt", "<CMD>TodoTrouble<CR>", { desc = "Todo list" })
