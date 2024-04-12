return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          n = {
            -- Close Telescope using ;j in normal mode
            [";j"] = actions.close,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-f>"] = actions.preview_scrolling_left,
            ["<C-b>"] = actions.preview_scrolling_right,
          },
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-l>"] = actions.select_default,

            ["<C-S-h>"] = actions.results_scrolling_left,
            ["<C-S-l>"] = actions.results_scrolling_right,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-f>"] = actions.preview_scrolling_left,
            ["<C-b>"] = actions.preview_scrolling_right,
          },
        },
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
        },
      },
      -- Setup Telescope undo
      extensions = {
        undo = {
          use_delta = false,
        },
      },
    })
    require("telescope").load_extension("undo")
  end,
  keys = {
    { "<leader>U", "<cmd>Telescope undo<cr>", desc = "Telescope Undo" },
    { "U", "<cmd>Telescope undo<cr>", desc = "Telescope Undo" },
  },
}
