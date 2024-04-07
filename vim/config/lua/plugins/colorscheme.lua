return {
  -- Select catppuccin as colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        -- Chose catppuccin flavour
        flavour = "macchiato",

        -- Enable integrations for window_picker
        integrations = {
          window_picker = true,
        },

        -- Enable dim inactive in catppuccin
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
      })
    end,
  },
}
