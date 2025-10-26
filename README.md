# Neovim Configuration

A modern Neovim configuration built with [Lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager, featuring LSP support, code formatting, linting, and quality-of-life enhancements.

## Features

- **Plugin Management**: Lazy.nvim for fast, declarative plugin management
- **LSP Support**: Full Language Server Protocol integration with automatic installation
- **Code Formatting**: Format on save with conform.nvim (Prettier, Stylua, Black, etc.)
- **Linting**: Real-time linting with nvim-lint
- **Syntax Highlighting**: Treesitter-based parsing and highlighting
- **Auto-completion**: Intelligent completion via nvim-cmp
- **Fuzzy Finding**: Telescope for files, buffers, and more
- **Session Management**: Auto-restore sessions per directory
- **Git Integration**: Built-in Git support

## Installation

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. **Launch Neovim**:
   ```bash
   nvim
   ```
   Lazy.nvim will automatically install all plugins on first launch.

## Requirements

- Neovim >= 0.9.0
- Git
- Node.js (for LSP servers and formatters)
- Python 3 with pip (for Python LSP and tools)
- A Nerd Font (for icons)

## Structure

```
~/.config/nvim/
├── init.lua                   # Entry point
├── lua/tony/
│   ├── core/
│   │   ├── init.lua          # Core loader
│   │   ├── options.lua       # Vim options
│   │   └── keymaps.lua       # General keymaps
│   ├── lazy.lua              # Plugin manager setup
│   ├── lsp.lua               # LSP configuration
│   └── plugins/
│       ├── lsp/
│       │   ├── mason.lua     # LSP/tool installer
│       │   └── lsp.lua       # LSP server configs
│       ├── formatting.lua    # Formatter config
│       ├── linting.lua       # Linter config
│       ├── treesitter.lua    # Syntax parsing
│       └── *.lua             # Individual plugins
├── after/
│   ├── lsp/                  # Per-server overrides
│   └── queries/              # Treesitter queries
├── lazy-lock.json            # Plugin version lock
└── .stylua.toml             # Lua formatter config
```

## Keymaps

**Leader key**: `<Space>`

### General
| Keymap | Mode | Description |
|--------|------|-------------|
| `jk` | Insert | Exit to normal mode |
| `<leader>nh` | Normal | Clear search highlights |
| `<leader>+` | Normal | Increment number |
| `<leader>-` | Normal | Decrement number |

### Window Management
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>sv` | Normal | Split vertically |
| `<leader>sh` | Normal | Split horizontally |
| `<leader>se` | Normal | Equalize splits |
| `<leader>sx` | Normal | Close split |

### Tab Management
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>to` | Normal | New tab |
| `<leader>tx` | Normal | Close tab |
| `<leader>tn` | Normal | Next tab |
| `<leader>tp` | Normal | Previous tab |
| `<leader>tf` | Normal | Open buffer in new tab |

### LSP
| Keymap | Mode | Description |
|--------|------|-------------|
| `gR` | Normal | Show references |
| `gD` | Normal | Go to declaration |
| `gd` | Normal | Go to definition |
| `gi` | Normal | Show implementations |
| `gt` | Normal | Show type definitions |
| `<leader>ca` | Normal/Visual | Code actions |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>D` | Normal | Buffer diagnostics |
| `<leader>d` | Normal | Line diagnostics |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `K` | Normal | Hover documentation |
| `<leader>rs` | Normal | Restart LSP |

### Formatting & Linting
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>mp` | Normal/Visual | Format file/selection |
| `<leader>l` | Normal | Lint file |

## Language Support

### Installed LSP Servers
- **TypeScript/JavaScript**: ts_ls
- **Web**: html, cssls, tailwindcss, emmet_ls
- **Lua**: lua_ls
- **Python**: pyright
- **GraphQL**: graphql
- **Linting**: eslint

### Formatters
- **JS/TS/React/Svelte/CSS/HTML/JSON/YAML/Markdown/GraphQL**: Prettier
- **Lua**: Stylua
- **Python**: isort + black

### Linters
- **Python**: pylint
- **JavaScript/TypeScript**: eslint_d (configurable)

## Customization

### Adding a Plugin

1. Create `lua/tony/plugins/plugin-name.lua`:
   ```lua
   return {
     "author/plugin-name",
     opts = {
       -- options here
     },
   }
   ```
2. Restart Neovim - plugins auto-install

### Adding an LSP Server

1. Add to `ensure_installed` in `lua/tony/plugins/lsp/mason.lua`
2. Configure in `lua/tony/plugins/lsp/lsp.lua` (if needed)
3. Create `after/lsp/[server-name].lua` for overrides (optional)

### Adding a Formatter/Linter

1. Add to `mason-tool-installer` in `lua/tony/plugins/lsp/mason.lua`
2. Configure in `lua/tony/plugins/formatting.lua` or `lua/tony/plugins/linting.lua`

## Configuration Highlights

- **Format on save**: Enabled with 3s timeout
- **Auto-save sessions**: Sessions restore automatically per directory
- **System clipboard**: Integrated by default
- **Relative line numbers**: With absolute current line
- **No swap files**: Disabled for cleaner workflow
- **Smart indentation**: 2 spaces, auto-indent enabled

## Updating

Plugins are locked via `lazy-lock.json`. To update:

```vim
:Lazy update
```

## Troubleshooting

### LSP server not starting
```vim
:LspInfo
:Mason
```

### Formatter not working
```vim
:ConformInfo
```

### Checking installed tools
```vim
:Mason
```

## License

This configuration is available for personal use and modification.
