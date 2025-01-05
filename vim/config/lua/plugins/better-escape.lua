-- Replace <Esc> key efficiently
return {
  "max397574/better-escape.nvim",
  event = { "LazyFile" }, -- Overrides default lazyvim keymaps
  opts = {
    default_mappings = false,
    mappings = {
      i = {
        [";"] = {
          j = "<Esc>",
        },
      },
      c = {
        [";"] = {
          j = "<Esc>",
        },
      },
      t = {
        [";"] = {
          j = "<C-\\><C-n>",
        },
      },
      v = {
        [";"] = {
          j = "<Esc>",
        },
      },
      s = {
        [";"] = {
          j = "<Esc>",
        },
      },
    },
  },
}
