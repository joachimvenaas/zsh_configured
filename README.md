# Zsh Configured

A one-command setup for a beautiful and productive Zsh environment with Oh My Zsh, Powerlevel10k, and useful tools.

## Features

- **Oh My Zsh** - Framework for managing Zsh configuration
- **Powerlevel10k** - Fast and customizable Zsh theme
- **zsh-autosuggestions** - Fish-like autosuggestions for Zsh
- **eza** - Modern replacement for `ls` with icons and git integration
- **zoxide** - Smarter `cd` command that learns your habits

## Quick Install

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/joachimvenaas/zsh_configured/main/install.sh)"
```

After installation, run `zsh` or restart your terminal.

## Requirements

- Debian/Ubuntu-based Linux distribution
- `curl` (will be installed if missing)
- Root or sudo access

## Font Setup

For the best experience with Powerlevel10k icons, install a Nerd Font:

1. Download [MesloLGS NF](https://www.nerdfonts.com/font-downloads) (search for "Meslo")
2. Install the font on your system
3. Set it as your terminal's font

## Included Aliases

| Alias | Command |
|-------|---------|
| `ls` | `eza --icons --group-directories-first` |
| `ll` | `eza -lah --icons --group-directories-first --git` |
| `la` | `eza -a --icons` |

## What Gets Installed

- Zsh shell
- Oh My Zsh framework
- Powerlevel10k theme
- zsh-autosuggestions plugin
- eza (modern ls replacement)
- zoxide (smart cd replacement)

## Backup

The installer automatically backs up existing `.zshrc` and `.p10k.zsh` files to `.zshrc.bak` and `.p10k.zsh.bak`.

## Customization

- Edit `~/.zshrc` to modify Zsh settings
- Run `p10k configure` to reconfigure the Powerlevel10k prompt
- Edit `~/.p10k.zsh` for manual prompt customization

## License

MIT
