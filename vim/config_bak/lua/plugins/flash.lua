-- Easymotion like plugin
return {
  "folke/flash.nvim",
  opts = {
    modes = {
      search = {
        enabled = false, -- disable search integration
      },
      char = {
        enabled = false, -- disable default f,F,t,T behaviour
      },
      treesitter = {
        highlight = {
          backdrop = true,
        },
      },
    },
  },
  -- Use function to override default mappings
  keys = function()
    -- stylua: ignore
    return {
      { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "t", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    }
  end,
}
