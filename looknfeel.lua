-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    -- Near-zero gaps and a hairline border.
    gaps_in = 2,
    gaps_out = 4,
    border_size = 1,
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
  decoration = {
    active_opacity = 1.0,
    inactive_opacity = 0.85,

    blur = {
      enabled = true,
      size = 3,
      passes = 2,
    },
  },
})

-- Alacritty gets its own transparency instead of the default window opacity.
o.window("Alacritty", { tag = "-default-opacity", opacity = "0.9 0.82" })

-- Scratchpad windows stay opaque and unblurred: layered rendering there is
-- expensive and the window is on top of everything anyway.
o.window({ workspace = "special:magic" }, { tag = "-default-opacity", opacity = "1.0 1.0", no_blur = true })
