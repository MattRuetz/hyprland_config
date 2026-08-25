-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

hl.env("GDK_SCALE", "2")

-- Anything not listed below: preferred mode, auto position and scale.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 2 })

-- HP V28 4K, left side (effective 2560x1440).
hl.monitor({ output = "DP-1", mode = "preferred", position = "0x0", scale = 1.5 })

-- Laptop display, right of the HP.
hl.monitor({ output = "eDP-1", mode = "preferred", position = "2560x0", scale = 2 })

-- Miracast virtual output, streamed to the MiraScreen dongle.
hl.monitor({ output = "HEADLESS-2", mode = "1920x1080@60", position = "5120x0", scale = 1 })
