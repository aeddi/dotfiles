-- Enable mouse event for tabs hover action
vim.opt.mousemoveevent = true

return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-neo-tree/neo-tree.nvim",
  },
  keys = {
    { "<C-S-h>", "<cmd>BufferLineMovePrev<cr>", mode = { "n", "i" }, desc = "Move buffer to the left" },
    { "<C-S-l>", "<cmd>BufferLineMoveNext<cr>", mode = { "n", "i" }, desc = "Move buffer to the right" },
  },

  opts = function(_, opts)
    -- Customize highlight for neo-tree title bar
    local neotree_hl = vim.api.nvim_get_hl(0, { name = "NeoTreeTitleBar" })
    vim.api.nvim_set_hl(0, "NeoTreeCustomTitle", vim.tbl_deep_extend("force", neotree_hl, { bold = true }))

    return vim.tbl_deep_extend("force", opts, {
      options = {
        -- Display close button on hover only
        hover = {
          enabled = true,
          delay = 100,
          reveal = { "close" },
        },
        separator_style = "slope",
        -- Customize neo-tree title bar displayed when bufferline is displayed
        offsets = {
          {
            filetype = "neo-tree",
            text = "󰙅 File Explorer",
            text_align = "center",
            highlight = "NeoTreeCustomTitle",
            separator = true,
          },
        },
      },
    })
  end,
}
