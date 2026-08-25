# Restore

Copies of the config that lives outside `~/.config/hypr`, so a reinstall or a
distro upgrade that resets defaults can be undone from one place.

Run `./sync.sh` after changing any of it to refresh these copies, then commit.

| Path here | Lives at |
|---|---|
| `bin/` | `~/.local/bin/` |
| `systemd/` | `~/.config/systemd/user/` |
| `omarchy/shell.json` | `~/.config/omarchy/shell.json` |
| `tmux/tmux.conf`, `tmux/session-color.sh` | `~/.config/tmux/` |
| `tmux/dot-tmux.conf` | `~/.tmux.conf` |
| `config/bashrc` | `~/.bashrc` |
| `config/mimeapps.list` | `~/.config/mimeapps.list` |
| `config/environment.d-10-editor.conf` | `~/.config/environment.d/10-editor.conf` |
| `theme-classical-paintings/` | `~/.config/omarchy/themes/classical-paintings/` |

The paintings themselves are not in git. Re-download them with
`bin/classical-paintings-download`, then `bin/classical-paintings-expand`.

## Omarchy Quattro notes

Quattro moved Hyprland config from `.conf` to `.lua` and wrote fresh templates
over the top, which reads as "everything is gone". It is not: the old `.conf`
files are still in `~/.config/hypr`, unread. The `.lua` files in this repo are
the ported versions.

Other Quattro changes worth knowing about:

- `~/.local/share/omarchy` moved to `/usr/share/omarchy`, and the old tree was
  renamed to `*.omarchy-upgrade-to-quattro.<timestamp>.bak`. Every config it
  replaced got the same suffix, so `find ~ -name '*omarchy-upgrade-to-quattro*'`
  lists what it touched.
- waybar, mako, walker and swayosd are gone, replaced by the Quickshell-based
  omarchy shell. Their configs survive under the same backup suffix.
- `~/.config/uwsm/env` and `env/default` are gone. Session-wide env vars go in
  `~/.config/environment.d/` now.
