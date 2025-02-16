return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  opts = {
    hint = "floating-big-letter",
    show_prompt = false,
    filter_rules = {
      bo = {
        -- if the file type is one of following, the window will be ignored
        filetype = {
          "neo-tree",
          "neo-tree-popup",
          "notify",
          "Trouble",
          "noice",
          "CustomPopup",
          "scrollview",
          "scrollview_sign",
          "cmp_menu",
          "cmp_docs",
        },
        -- if the buffer type is one of following, the window will be ignored
        buftype = { "terminal", "quickfix" },
      },
    },
  },
}
