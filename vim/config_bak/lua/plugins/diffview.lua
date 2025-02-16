return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
    "DiffviewLog",
  },
  -- stylua: ignore
  keys = {
    { "<leader>gD", function() require("diffview").open() end, mode = { "n" }, desc = "Open diff view" },
    { "<leader>gC", function() require("diffview").close() end, mode = { "n" }, desc = "Close diff view" },
  },
}
