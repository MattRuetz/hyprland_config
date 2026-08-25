-- Personal input overrides. Uncommented settings replace Omarchy's defaults.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    kb_layout = "us",
    kb_options = "compose:caps",

    repeat_rate = 40,
    repeat_delay = 600,

    numlock_by_default = true,

    touchpad = {
      natural_scroll = true,
      clickfinger_behavior = true,
      scroll_factor = 0.4,
    },
  },
})

-- Scroll nicely in the terminal.
o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Three-finger horizontal swipe changes workspace.
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
