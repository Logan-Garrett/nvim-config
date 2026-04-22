# Neovim Config

Multi-language Neovim setup with LSP, completion, and tools from ThePrimeagen, TJ DeVries, and Folke.

## Setup

```bash
git clone https://github.com/Logan-Garrett/nvim-config.git ~/.config/nvim
nvim
```

Lazy.nvim will auto-install plugins on first launch. Mason will auto-install LSP servers.

## Plugins

| Plugin | Purpose |
|--------|---------|
| **catppuccin** | Color scheme (mocha) |
| **lazy.nvim** | Plugin manager |
| **mason + mason-lspconfig** | Auto-install LSP servers |
| **nvim-cmp + LuaSnip** | Completion + snippets |
| **nvim-treesitter** | Syntax highlighting + parsing |
| **treesitter-context** | Sticky function headers |
| **telescope** | Fuzzy finder |
| **harpoon 2** | File bookmarks |
| **undotree** | Undo history |
| **vim-fugitive** | Git wrapper |
| **oil.nvim** | File explorer as buffer |
| **conform.nvim** | Auto-format on save |
| **gitsigns** | Git gutter + inline blame |
| **flash.nvim** | Fast jump/motion |
| **refactoring.nvim** | Extract/inline refactors |
| **zen-mode** | Distraction-free editing |
| **nvim-dap + dap-ui** | Debugger |
| **trouble.nvim** | Diagnostics list |
| **todo-comments** | Highlight TODO/FIXME/HACK |
| **which-key** | Keybinding hints |
| **noice.nvim** | Better command line + notifications |
| **Comment.nvim** | Toggle comments |
| **nvim-surround** | Add/change/delete surrounds |
| **nvim-autopairs** | Auto-close brackets |
| **indent-blankline** | Indent guides |
| **lualine** | Statusline |
| **dressing.nvim** | Better select/input UI |
| **fidget.nvim** | LSP progress spinner |

## LSP Servers (auto-installed)

C# (omnisharp), Lua (lua_ls), Rust (rust_analyzer), Python (pyright), TypeScript (ts_ls), Go (gopls), OCaml (ocamllsp), Scala (metals), C/C++ (clangd), Java (jdtls), Zig (zls), Bash (bashls), HTML, CSS, JSON, YAML

## Keybindings

Leader is `\` (default).

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `K` | Hover docs |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |

### Telescope
| Key | Action |
|-----|--------|
| `<leader>pf` | Find files |
| `<C-p>` | Git files |
| `<leader>ps` | Grep string |
| `<leader>lg` | Live grep |

### Harpoon
| Key | Action |
|-----|--------|
| `<leader>a` | Add file |
| `<C-e>` | Toggle menu |
| `<C-h>` | Slot 1 |
| `<C-t>` | Slot 2 |
| `<C-n>` | Slot 3 |
| `<C-j>` | Slot 4 |

### Navigation & Editing
| Key | Action |
|-----|--------|
| `s` / `S` | Flash jump / treesitter jump |
| `-` | Oil file explorer |
| `gcc` | Comment line |
| `gc` | Comment selection (visual) |
| `cs"'` | Change surrounding `"` to `'` |
| `ys` / `ds` | Add / delete surround |

### Git
| Key | Action |
|-----|--------|
| `<leader>gs` | Fugitive (git status) |
| `]h` / `[h` | Next / prev hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |

### Refactoring
| Key | Action |
|-----|--------|
| `<leader>re` | Extract function (visual) |
| `<leader>rv` | Extract variable (visual) |
| `<leader>ri` | Inline variable |

### Debugger
| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>du` | Toggle DAP UI |

### Diagnostics
| Key | Action |
|-----|--------|
| `<leader>xx` | All diagnostics |
| `<leader>xd` | Buffer diagnostics |
| `<leader>xt` | Todo list |

### Other
| Key | Action |
|-----|--------|
| `<leader>u` | Undotree |
| `<leader>zz` | Zen mode |
