<div align=center>

# initSyscall/nvim
> This is my neovim config built around Minimalism, functionality, modularity, and aesthetic. This config has everything I may need for my present and future development. Contains: a single-pane neo-tree explorer, LSP, DAP, Code Runner and Opencode Support.


</div>



## Preview

<pre>

Dashboard

<img src="https://codeberg.org/initsyscall/nvim/raw/branch/main/screenshots/dashboard.png" alt="dashboard"/>

Coding

<img src="https://codeberg.org/initsyscall/nvim/raw/branch/main/screenshots/coding.png" alt="coding"/>
  
</pre>


## Requirements
- Neovim >= 0.10
- Nerd Font (for icons)
- Git

## Features
- File explorer: neo-tree (single pane, netrw-style), toggled with `<leader>e` (`h`/`l`/`L` to navigate)
- LSP (lua_ls, pyright) with Mason integration
- First-class Rust support via rustaceanvim (`<leader>R`)
- DAP for Python, C/C++, Rust (codelldb)
- Integrated code runner for quick script execution
- Treesitter, autocompletion (blink.cmp), automatic formatting (conform.nvim)
- Modular Lua plugin structure with lazy.nvim

> [!NOTE]
> Disable Rust support by setting `rust.enabled = false` in `lua/config/lsp.lua`.

## Installation
```bash
git clone https://codeberg.org/initSyscall/nvim.git ~/.config/nvim
```

Open Neovim - plugins will auto-install on first launch.

## License
Apache License 2.0 - see [LICENSE](LICENSE) file for details.

