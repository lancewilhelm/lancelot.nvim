# lancelot.nvim

Yet another neovim configuration, nearly like the [LazyVim](https://www.lazyvim.org/) distro, but with my preferences and spin on it all. Below I will detail what I have included, with some rationale. This configuration started from the great template [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Introduction

Some overall bullet points:

* Uses [lazy.nvim](https://github.com/folke/lazy.nvim) package manager
* [Catppuccin](https://github.com/catppuccin/nvim?tab=readme-ov-file) theme (for now)
* Attempts to have visual goodies with goodness of sweet sweet key mappings
* Catered to my tastes (opinionated)

## Installation

Likely a lot of the same setup as kickstart.

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If want to write Typescript, you need `npm`
  - If want to write Golang, you will need `go`
  - etc.

### Install lancelot.nvim

> **NOTE**
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%userprofile%\AppData\Local\nvim\` |
| Windows (powershell)| `$env:USERPROFILE\AppData\Local\nvim\` |

#### Clone kickstart.nvim
> **NOTE**
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git %userprofile%\AppData\Local\nvim\
```

If you're using `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git $env:USERPROFILE\AppData\Local\nvim\
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` or `<leader>l` to view
current plugin status. Hit `q` to close the window.

## Keymaps

This config uses [which-key.nvim](https://github.com/folke/which-key.nvim) to help with key mappings. You can either start by pressing the leader key `<space>` or you can search through the keymaps with telescope by pressing `<leader>sk`.

## Plugins

*section coming soon*
