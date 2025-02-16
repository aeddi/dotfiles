return {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      ["<leader>m"] = { name = "+misc" },
      ["<leader>r"] = { name = "+run" },
      ["<leader>gh"] = { name = "+hunk" },
      ["<leader>ghz"] = { name = "" }, -- Use just to force which-key to display hunk name
    },
    window = {
      border = "rounded",
    },
  },
}
