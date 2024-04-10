-- Colorize html codes (e.g. #ff0000)
return {
  "norcalli/nvim-colorizer.lua",
  opts = {
    "*", -- Highlight all files, but customize some others.
    "!noice",
    css = { css = true, css_fn = true },
    html = { css = true, css_fn = true },
  },
}
