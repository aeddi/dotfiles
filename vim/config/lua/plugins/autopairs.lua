return {
  -- Disable default LazyVim mini.pairs
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  -- Enable custom autopairs plugin
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}
