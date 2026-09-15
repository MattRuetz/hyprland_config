-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all
--
-- Two layouts, switched with `monitor-profile` (Super+R -> Monitor profile):
--   default  - external monitor landscape, left of the laptop
--   vertical - external monitor rotated 90 CCW, left of the laptop
-- Positions are auto-right, so either external panel (BenQ 1080p or HP 4K)
-- places the laptop correctly with no gap or overlap.

hl.env("GDK_SCALE", "3")

local profile = "default"
do
  local f = io.open((os.getenv("HOME") or "") .. "/.local/state/omarchy/monitor-profile", "r")
  if f then
    local value = (f:read("l") or ""):gsub("%s+", "")
    f:close()
    if value ~= "" then
      profile = value
    end
  end
end

-- Anything not listed below: preferred mode, auto position and scale.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 3 })

-- External monitor, leftmost.
hl.monitor({
  output = "DP-1",
  mode = "preferred",
  position = "0x0",
  scale = 1.5,
  transform = profile == "vertical" and 3 or 0,
})

-- Laptop display, right of the external.
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto-right", scale = 2 })

-- Miracast virtual output, streamed to the MiraScreen dongle.
hl.monitor({ output = "HEADLESS-2", mode = "1920x1080@60", position = "auto-right", scale = 1 })
