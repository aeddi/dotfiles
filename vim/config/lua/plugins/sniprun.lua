return {
  "michaelb/sniprun",
  build = "sh install.sh",
  opts = {
    live_mode_toggle = "enable",
  },
  keys = {
    {
      "<leader>rr",
      function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" or mode == "" then
          require("sniprun").run("v")
        else
          require("sniprun").run()
        end
      end,
      mode = { "n", "v" },
      desc = "Run current/selected line(s)",
    },
    {
      "<leader>rs",
      function()
        require("sniprun").reset()
        require("sniprun.display").close_all()
        if vim.fn.exists("#_sniprunlive#TextChanged") ~= 0 then
          require("sniprun.live_mode").disable()
        end
      end,
      desc = "Stop running code and clear",
    },
    { "<leader>rl", "<cmd>SnipLive<cr>", desc = "Toggle live running code" },
    { "<leader>ri", "<cmd>SnipInfo<cr>", desc = "SnipRun info" },
  },
}
