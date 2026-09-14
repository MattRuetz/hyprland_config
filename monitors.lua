-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

hl.env("GDK_SCALE", "3")

-- Anything not listed below: preferred mode, auto position and scale.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 3 })

-- BenQ GW2780, left side, rotated 90 CCW (effective 720x1280).
hl.monitor({ output = "DP-1", mode = "preferred", position = "0x0", scale = 1.5, transform = 3 })

-- Laptop display, right of the BenQ.
hl.monitor({ output = "eDP-1", mode = "preferred", position = "720x0", scale = 2 })

-- Miracast virtual output, streamed to the MiraScreen dongle.
hl.monitor({ output = "HEADLESS-2", mode = "1920x1080@60", position = "2256x0", scale = 1 })
