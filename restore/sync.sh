#!/bin/bash
# Refresh the copies in this directory from the live config.
set -euo pipefail

cd "$(dirname "$0")"

cp ~/.local/bin/{classical-paintings-download,classical-paintings-expand,classical-paintings-expand-japanese,classical-paintings-expand-v3,classical-paintings-next,classical-paintings-remove,cdsp,dictation-toggle,nightlight-adjust,autoclicker,autoclicker.py,flstudio,ss,sudo-askpass} bin/
cp ~/.config/systemd/user/{classical-paintings-daily.service,classical-paintings-daily.timer,wled-deck.service,hermes-gateway.service} systemd/
cp ~/.config/omarchy/shell.json omarchy/
cp ~/.config/tmux/tmux.conf ~/.config/tmux/session-color.sh tmux/
cp ~/.tmux.conf tmux/dot-tmux.conf
cp ~/.bashrc config/bashrc
cp ~/.config/mimeapps.list config/mimeapps.list
cp ~/.config/environment.d/10-editor.conf config/environment.d-10-editor.conf
cp ~/.config/omarchy/themes/classical-paintings/{colors.toml,btop.theme,icons.theme,neovim.lua,vscode.json} theme-classical-paintings/

echo "Synced. Review with git diff, then commit."
