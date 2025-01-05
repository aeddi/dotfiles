-- Floating Breadcrumb navigation
return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },

  opts = function(_)
    local actions = require("nvim-navbuddy")

    return {
      lsp = {
        auto_attach = true,
      },
      window = {
        border = "rounded",
      },
      mappings = {
        -- [";j"] = actions.close(), // Doesn't work ???
      },
    }
  end,
  keys = {
    { "<leader>cN", "<cmd>Navbuddy<cr>", desc = "Breadcrumb navigation" },
  },
}
