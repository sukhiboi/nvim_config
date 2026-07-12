# nvim_config

A Neovim configuration built to feel like IntelliJ IDEA Ultimate: LSP-powered
navigation/refactoring, integrated debugging, test running, an HTTP client,
and a full Git panel — all wired up with sensible IntelliJ-equivalent
keybindings.

## Structure

```
init.lua                 -- thin loader, requires the three files below
lua/config/options.lua   -- core vim options
lua/config/keymaps.lua   -- leader key, general keybindings, IntelliJ cheatsheet
lua/config/lazy.lua      -- bootstraps lazy.nvim, auto-loads lua/plugins/*.lua
lua/plugins/*.lua        -- one file per feature/plugin
ftplugin/java.lua        -- jdtls + Spring Boot Tools + debug/test bundles (per Java buffer)
```

Adding a new plugin means dropping a new file in `lua/plugins/` — no need to
touch `init.lua` or the lazy setup.

## Requirements

- Neovim >= 0.11 (uses `vim.lsp.config()` / `vim.lsp.enable()`)
- `git`, a C compiler (for Treesitter parsers), and the `tree-sitter` CLI
  (`brew install tree-sitter-cli`)
- A JDK (21+) on `PATH` for Java/Spring Boot support (via jdtls)
- `node`/`npm` for the TypeScript/JS tooling (ts_ls, eslint, prettier, Jest)
- `ripgrep` for Telescope live grep

On first launch, `lazy.nvim` auto-installs itself and every plugin. Run
`:Mason` afterwards to check/install language servers, and `:MasonToolsInstall`
to check the formatter/debug-adapter binaries.

## Language support

| Language        | LSP            | Notes                                   |
|-----------------|----------------|------------------------------------------|
| C               | clangd         |                                          |
| JS/TS/JSX/TSX   | ts_ls + eslint | eslint catches project lint rules        |
| Python          | pyright + ruff | pyright = types, ruff = linting          |
| Java            | jdtls          | full setup, see below                    |
| SQL / Postgres  | sqlls + postgres_lsp | layered: general SQL + Postgres extras |
| JSON / YAML     | jsonls / yamlls |                                         |
| Markdown        | marksman       |                                          |

### Java / Spring Boot

`ftplugin/java.lua` starts `jdtls` per-project (root detected via
`pom.xml`/`build.gradle`/`.git`) with:
- **Spring Boot Tools** bundled in (bean/endpoint navigation, `application.properties` completion)
- **java-debug-adapter** wired into `nvim-dap` for breakpoints/stepping
- **java-test** for JUnit — `<leader>jtc` run test class, `<leader>jtm` run nearest method
- Refactors: `<leader>jo` organize imports, `<leader>jv`/`<leader>jc` extract variable/constant, `<leader>jm` extract method

### Formatting & linting

`<leader>lf` runs [conform.nvim](https://github.com/stevearc/conform.nvim)
(prettier, stylua, ruff_format, google-java-format, sql_formatter), falling
back to LSP formatting. Format-on-save is enabled.

### Testing & debugging

- [neotest](https://github.com/nvim-neotest/neotest) + neotest-jest: `<leader>tt` run nearest test, `<leader>td` debug nearest test, `<leader>ts` summary panel
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) + nvim-dap-ui: `F5` continue, `F9` breakpoint, `F10`/`F11` step over/into — wired for Java and JS/TS/Jest

### HTTP client

[kulala.nvim](https://github.com/mistweaverco/kulala.nvim) — open a `.http`
file, `<leader>hh` sends the request under the cursor (like IntelliJ's HTTP
Client).

## Keybindings

Leader is `<Space>`. Press it and wait to bring up which-key, which lists
every mapping under whatever prefix you're typing.

| IntelliJ            | Neovim                 | What it does                  |
|---------------------|------------------------|--------------------------------|
| Alt+Enter            | `<Space>a` / `Alt+CR`  | Code actions / quick fix        |
| Cmd+B                | `gd`                   | Go to definition                 |
| Cmd+E                | `<Space>e`             | Recent files                     |
| Cmd+Shift+O          | `<Space>o`             | Find files                       |
| Cmd+Shift+F          | `<Space>f`             | Search in all files              |
| Cmd+Shift+R          | `<Space>r`             | Search & replace in files        |
| Cmd+Alt+L            | `<Space>lf`            | Format file                      |
| Shift+F6             | `<Space>rn`            | Rename symbol                    |
| Alt+F7               | `<Space>u` / `gr`      | Find usages                      |
| Ctrl+W               | `Enter` (normal mode)  | Expand selection                 |
| Cmd+/                | `gcc`                  | Toggle comment                   |
| Alt+1                | `<Space>t`             | Toggle file tree                 |
| Ctrl+Tab             | `Shift+L` / `Shift+H`  | Next/prev tab                    |
| F2                   | `]d`                   | Next error/warning               |
| Cmd+P                | `Ctrl+P` (insert mode) | Parameter info                   |
| (n/a)                | `<Space>+` / `<Space>-`| Increment/decrement number       |
| Problems panel       | `<Space>xx` / `<Space>xd` | Diagnostics (workspace/file) |
| TODO tool window     | `<Space>xt`, `]t`/`[t` | TODO list / jump next-prev        |
| Git tool window      | `<Space>gg`            | Full Git panel (neogit)          |
| Run test             | `<Space>tt`            | Run nearest test (Jest)          |
| Debug test           | `<Space>td`            | Debug nearest test                |

## Known environment notes

- The `tree-sitter` CLI is a separate Homebrew formula from `tree-sitter`
  (the library) — install `tree-sitter-cli` if parsers fail to compile.
- `nvim-treesitter` is pinned to its `main` branch (the Neovim-core rewrite),
  which dropped the old `configs.setup()` API — see `lua/plugins/treesitter.lua`.
- `mason-lspconfig` >= 2.0 dropped `setup_handlers()` in favor of Neovim's
  native `vim.lsp.config()`/`vim.lsp.enable()` — see `lua/plugins/lsp.lua`.
