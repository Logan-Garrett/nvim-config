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

Leader is `<space>`.

### Built-in Vim Motions

#### Movement
| Key | Action |
|-----|--------|
| `w` / `b` | Word forward / back |
| `W` / `B` | WORD forward / back (skips punctuation) |
| `f<char>` / `F<char>` | Jump to char on line (`;` to repeat) |
| `0` / `$` | Start / end of line |
| `^` | First non-blank character |
| `{` / `}` | Jump between blank lines |
| `gg` / `G` | Top / bottom of file |
| `<number>G` | Jump to line number |
| `%` | Jump to matching bracket |
| `*` / `#` | Search word under cursor forward / backward |

#### Editing
| Key | Action |
|-----|--------|
| `ciw` | Change inner word |
| `ci"` / `ci(` / `ci{` | Change inside quotes / parens / braces |
| `di"` / `da"` | Delete inside / around quotes |
| `viw` / `vi"` | Select inside word / quotes |
| `yiw` | Yank inner word |
| `p` / `P` | Paste after / before cursor |
| `o` / `O` | New line below / above + insert mode |
| `A` / `I` | Insert at end / start of line |
| `.` | Repeat last change |
| `~` | Toggle case |
| `>>` / `<<` | Indent / dedent line |
| `<C-a>` / `<C-x>` | Increment / decrement number |

#### Visual Mode
| Key | Action |
|-----|--------|
| `v` | Character select |
| `V` | Line select |
| `<C-v>` | Block select (multi-line editing) |

### Prime's Custom Remaps

| Key | Action |
|-----|--------|
| `<C-d>` / `<C-u>` | Half page down / up (cursor stays centered) |
| `n` / `N` | Next / prev search result (centered) |
| `J` | Join lines (cursor stays in place) |
| `J` / `K` (visual) | Move selected lines down / up |
| `<space>p` (visual) | Paste over selection without losing register |
| `<space>y` | Yank to system clipboard |
| `<space>Y` | Yank line to system clipboard |
| `<space>d` | Delete to void (don't pollute yank register) |
| `<space>s` | Replace word under cursor (whole file) |
| `<space>x` | Make current file executable |
| `Q` | Disabled (prevents accidental ex mode) |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `K` | Hover docs |
| `<space>rn` | Rename symbol |
| `<space>ca` | Code action |

### Telescope
| Key | Action |
|-----|--------|
| `<space>pf` | Find files |
| `<C-p>` | Git files |
| `<space>ps` | Grep string |
| `<space>lg` | Live grep |

### Harpoon
| Key | Action |
|-----|--------|
| `<space>a` | Add file |
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
| `<space>gs` | Fugitive (git status) |
| `]h` / `[h` | Next / prev hunk |
| `<space>hp` | Preview hunk |
| `<space>hb` | Blame line |

### Refactoring
| Key | Action |
|-----|--------|
| `<space>re` | Extract function (visual) |
| `<space>rv` | Extract variable (visual) |
| `<space>ri` | Inline variable |

### Debugger
| Key | Action |
|-----|--------|
| `<space>db` | Toggle breakpoint |
| `<space>dc` | Continue |
| `<space>do` | Step over |
| `<space>di` | Step into |
| `<space>du` | Toggle DAP UI |

### Diagnostics
| Key | Action |
|-----|--------|
| `<space>xx` | All diagnostics |
| `<space>xd` | Buffer diagnostics |
| `<space>xt` | Todo list |

### Other
| Key | Action |
|-----|--------|
| `<space>u` | Undotree |
| `<space>zz` | Zen mode |

## Tips

- **Think verb + noun**: `d` = delete, `c` = change, `y` = yank, `v` = select. Combine with `iw` (inner word), `i"` (inner quotes), `ap` (around paragraph), `$` (to end), etc.
- **Press `<space>` and wait** for which-key to show all available bindings.
- **Use marks**: `ma` sets mark `a`, `'a` jumps back to it.
- Built-in `:Tutor` for vim motion practice.
