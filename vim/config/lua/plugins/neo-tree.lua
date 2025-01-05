return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    window = {
      width = 32,
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = false } },
      },
    },
  },
}
