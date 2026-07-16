<div align=center>

# initSyscall/nvim
> My neovim config [Full IDE Experience]. Minimal, highly functional, modular, and aesthetic. This config have everything i may need for my future development. Contains: LSP, DAP, and a Code Runner - Full IDE experience.


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
- LSP support (lua_ls, pyright) with Mason integration
- DAP (debugging) for Python, C/C++, Rust
- Integrated code runner for quick script execution
- Treesitter, autocompletion (blink.cmp), automatic formatting (conform.nvim)
- Modular Lua plugin structure with lazy.nvim

## Installation
```bash
git clone https://codeberg.org/initSyscall/nvim.git ~/.config/nvim
```

Open Neovim - plugins will auto-install on first launch.

## License
Apache License 2.0 - see [LICENSE](LICENSE) file for details.

