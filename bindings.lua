-- Personal keybinding overrides, ported from the pre-Quattro bindings.conf
-- (still on disk as ~/.config/hypr/bindings.conf for reference).
-- See current bindings: omarchy menu keybindings --print

-- Vim-style focus movement.
hl.unbind("SUPER + J") -- was: Toggle window split
hl.unbind("SUPER + K") -- was: Keybindings menu
hl.unbind("SUPER + L") -- was: Toggle workspace layout
o.bind("SUPER + H", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + L", "Focus right", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + J", "Focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + K", "Focus down", hl.dsp.focus({ direction = "d" }))

-- SUPER + SPACE closes the window, SUPER + F is the launcher.
hl.unbind("SUPER + SPACE") -- was: Omarchy menu
hl.unbind("SUPER + F") -- was: Full screen
hl.unbind("SUPER + W") -- was: Close window
o.bind("SUPER + SPACE", "Close window", hl.dsp.window.close())
o.bind("SUPER + F", "Launch apps", "omarchy-menu toggle apps")

-- Keep SUPER + ALT + SPACE on the full Omarchy menu.
-- Upstream repointed it at the apps menu; SUPER + F already covers that.
hl.unbind("SUPER + ALT + SPACE") -- was: Apps menu
o.bind("SUPER + ALT + SPACE", "Omarchy menu", "omarchy-menu toggle")
o.bind("SUPER + CTRL + SHIFT + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Apps.
hl.unbind("SUPER + O") -- was: Pop window out (float & pin)
hl.unbind("SUPER + C") -- was: Universal copy
hl.unbind("SUPER + X") -- was: Universal cut
hl.unbind("SUPER + V") -- was: Universal paste
hl.unbind("SUPER + ESCAPE") -- was: System menu
o.bind("SUPER + Z", "Zen Browser", { launch = "zen-browser" })
o.bind("SUPER + E", "Emoji picker", { launch = "smile" })
o.bind("SUPER + N", "Notification history", "omarchy-shell notifications showHistory")
o.bind("SUPER + O", "Obsidian", { launch = "obsidian" })
o.bind("SUPER + D", "File manager", { launch = "nautilus" })
o.bind("SUPER + C", "Chromium", { launch = "chromium" })
o.bind("SUPER + X", "cdsp", o.launch("alacritty -e " .. os.getenv("HOME") .. "/.local/bin/cdsp"))
o.bind("SUPER + T", "Toggle floating", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + ESCAPE", "Lock screen", "omarchy-system-lock")
o.bind("SUPER + M", "Logout", "omarchy-system-logout")

-- Wallpaper rotation for the classical-paintings theme.
hl.unbind("SUPER + SHIFT + W") -- was: Omawrite
o.bind("SUPER + W", "Next painting", os.getenv("HOME") .. "/.local/bin/classical-paintings-next")
o.bind("SUPER + SHIFT + W", "Remove painting & next", os.getenv("HOME") .. "/.local/bin/classical-paintings-remove")

-- Night light nudges.
local nightlight_adjust = os.getenv("HOME") .. "/.local/bin/nightlight-adjust "
o.bind("SUPER + F2", "Night light warmer", nightlight_adjust .. "temp down")
o.bind("SUPER + F3", "Night light cooler", nightlight_adjust .. "temp up")
o.bind("SUPER + SHIFT + F2", "Night light dimmer", nightlight_adjust .. "brightness down")
o.bind("SUPER + SHIFT + F3", "Night light brighter", nightlight_adjust .. "brightness up")

-- Dictation and clipboard.
o.bind("SUPER + V", "Toggle dictation", "voxtype record toggle")
o.bind("SUPER + Multi_key", "Clipboard history", "omarchy-shell shell toggle omarchy.clipboard")

-- Scratchpad on TAB, on the "magic" special workspace.
hl.unbind("SUPER + TAB") -- was: Next workspace
hl.unbind("SUPER + SHIFT + TAB") -- was: Previous workspace
hl.unbind("SUPER + S") -- was: Toggle scratchpad (special:scratchpad)
o.bind("SUPER + TAB", "Toggle scratchpad", hl.dsp.workspace.toggle_special("magic"))
o.bind("SUPER + SHIFT + TAB", "Move to scratchpad", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse forward/back buttons switch workspace on the current monitor.
o.bind("mouse:276", "Next workspace (mouse fwd)", hl.dsp.focus({ workspace = "r+1" }), { mouse = true })
o.bind("mouse:275", "Previous workspace (mouse back)", hl.dsp.focus({ workspace = "r-1" }), { mouse = true })

-- Thumb button (BTN_FORWARD) toggles voxtype dictation, same as SUPER + V.
o.bind("mouse:277", "Toggle dictation (mouse thumb)", "voxtype record toggle", { mouse = true })
