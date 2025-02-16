-- Replace <Esc> key efficiently
return {
  "max397574/better-escape.nvim",
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
