return {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      ["<leader>t"] = { name = "+terminal ui" },
      ["<leader>r"] = { name = "+run" },
      ["<leader>gh"] = { name = "+hunk" },
      ["<leader>ghz"] = { name = "" }, -- Use just to force which-key to display hunk name
    },
    window = {
      border = "rounded",
    },
  },
}
