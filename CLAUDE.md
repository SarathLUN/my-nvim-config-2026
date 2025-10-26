# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration using Lazy.nvim as the plugin manager. The configuration follows a modular structure under the `tony` namespace with separate modules for core settings, LSP configuration, and individual plugin configurations.

## Architecture

### Entry Point & Loading Order

1. **init.lua** - Main entry point that loads in order:
   - `tony.core.init` - Core Neovim settings (options and keymaps)
   - `tony.lazy` - Plugin manager setup
   - `tony.lsp` - LSP keymaps and diagnostic configuration

### Directory Structure

```
init.lua                    # Main entry point
lua/tony/
  core/
    init.lua               # Loads options and keymaps
    options.lua            # Vim options (tabstop, line numbers, etc.)
    keymaps.lua            # General keymaps (leader = space)
  lazy.lua                 # Lazy.nvim bootstrap and setup
  lsp.lua                  # LSP keybindings and diagnostic config
  plugins/
    init.lua               # Plugin module marker
    lsp/
      mason.lua            # LSP server and tool installation
      lsp.lua              # LSP server configurations
    [individual-plugin].lua # One file per plugin
after/
  lsp/                     # Per-LSP-server overrides (eslint, graphql, etc.)
  queries/ecma/            # Treesitter query extensions
    textobjects.scm        # Custom textobject queries for JS/TS
```

### Plugin Management (Lazy.nvim)

- Plugins are auto-imported from `tony.plugins` and `tony.plugins.lsp`
- Each plugin is configured in its own file under `lua/tony/plugins/`
- `lazy-lock.json` locks plugin versions for reproducibility
- Auto-checker enabled but notifications disabled

## Key Configurations

### Code Formatting (conform.nvim)

**Location:** `lua/tony/plugins/formatting.lua`

- Format on save enabled (3s timeout)
- Manual format: `<leader>mp` (normal/visual mode)
- Formatters:
  - JavaScript/TypeScript/React/Svelte/CSS/HTML/JSON/YAML/Markdown/GraphQL: Prettier
  - Lua: Stylua (config in `.stylua.toml`)
  - Python: isort + black

### Linting (nvim-lint)

**Location:** `lua/tony/plugins/linting.lua`

- Auto-lint on: BufEnter, BufWritePost, InsertLeave
- Manual lint: `<leader>l`
- Linters:
  - Python: pylint
  - JavaScript/TypeScript: eslint_d (commented out, conditional logic present for config file detection)

### LSP Configuration

**Location:** `lua/tony/plugins/lsp/mason.lua` and `lua/tony/lsp.lua`

**Installed Language Servers:**
- ts_ls (TypeScript/JavaScript)
- html, cssls, tailwindcss
- lua_ls (Lua)
- graphql, emmet_ls
- pyright (Python)
- eslint

**LSP Keymaps (set on LspAttach):**
- `gR` - Show references (Telescope)
- `gD` - Go to declaration
- `gd` - Go to definition
- `gi` - Show implementations (Telescope)
- `gt` - Show type definitions (Telescope)
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>D` - Buffer diagnostics (Telescope)
- `<leader>d` - Line diagnostics (float)
- `[d` / `]d` - Previous/next diagnostic (with float)
- `K` - Hover documentation
- `<leader>rs` - Restart LSP

**Per-server LSP config:** `after/lsp/[server-name].lua` files override/extend server configs

### Treesitter

**Location:** `lua/tony/plugins/treesitter.lua` and `lua/tony/plugins/nvim-treesitter-text-objects.lua`

- Syntax highlighting and code parsing
- Custom textobjects for JS/TS objects via `after/queries/ecma/textobjects.scm`
- Textobject queries define `@property.lhs`, `@property.rhs`, `@property.inner`, `@property.outer`

## Common Keymaps

**Leader key:** `<space>`

**General:**
- `jk` (insert mode) - Exit to normal mode
- `<leader>nh` - Clear search highlights

**Window management:**
- `<leader>sv` / `<leader>sh` - Split vertically/horizontally
- `<leader>se` - Equalize split sizes
- `<leader>sx` - Close current split

**Tab management:**
- `<leader>to` - New tab
- `<leader>tx` - Close tab
- `<leader>tn` / `<leader>tp` - Next/previous tab
- `<leader>tf` - Open current buffer in new tab

**Increment/decrement:**
- `<leader>+` / `<leader>-` - Increment/decrement number under cursor

## Development Workflow

### Adding a New Plugin

1. Create `lua/tony/plugins/plugin-name.lua`
2. Return a lazy.nvim plugin spec:
   ```lua
   return {
     "author/plugin-name",
     opts = { ... },
     config = function() ... end,
   }
   ```
3. Restart Neovim - Lazy will auto-detect and install

### Adding a New LSP Server

1. Add server name to `ensure_installed` in `lua/tony/plugins/lsp/mason.lua`
2. If custom config needed, add in `lua/tony/plugins/lsp/lsp.lua`
3. For per-server overrides, create `after/lsp/[server-name].lua`

### Adding a Formatter/Linter

1. **Formatter:** Add tool to `mason-tool-installer` in `lua/tony/plugins/lsp/mason.lua`, then configure in `lua/tony/plugins/formatting.lua`
2. **Linter:** Add tool to `mason-tool-installer`, then configure in `lua/tony/plugins/linting.lua`

### Formatting Lua Files

Use Stylua with settings from `.stylua.toml`:
- 2 space indentation
- Format on save enabled for Lua files
- Manual format: `<leader>mp`

## Important Notes

- **Leader key is `<space>`** - all custom bindings use this prefix
- **Format on save is enabled** - 3 second timeout, may block on slow formatters
- **System clipboard integration** - yank/paste uses system clipboard by default
- **No swap files** - disabled in options
- **Auto-session enabled** - sessions restore automatically based on directory
- **Relative line numbers** with absolute current line number shown
