-- Floating Breadcrumb navigation
return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lsp = {
      auto_attach = true,
    },
    window = {
      border = "rounded",
    },
  },
  keys = {
    { "<leader>cn", "<cmd>Navbuddy<cr>", desc = "Breadcrumb navigation" },
  },
}
