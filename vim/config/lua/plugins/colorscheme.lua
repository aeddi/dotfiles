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
          barbecue = {
            dim_dirname = true, -- directory name is dimmed by default
            bold_basename = true,
            dim_context = false,
            alt_background = false,
          },
          blink_cmp = true,
          dap = true,
          dap_ui = true,
          flash = true,
          fzf = true,
          gitsigns = true,
          grug_far = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },

          mason = true,
          neotree = true,
          neotest = true,
          noice = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
              ok = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
              ok = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          render_markdown = true,
          treesitter = true,
          telescope = {
            enabled = true,
            -- style = "nvchad"
          },
          lsp_trouble = true,
          ufo = true,
          which_key = true,
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
