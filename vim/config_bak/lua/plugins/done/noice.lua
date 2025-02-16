return {
  "folke/noice.nvim",
  -- Override default Lazyvim noice config
  opts = function(_)
    return {
      cmdline = {
        view = "cmdline_popup", -- Use bottom bar for command instead of popup prompt
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          enabled = true, -- Enable displaying doc for fonction parameter
        },
      },
      markdown = {
        hover = {
          ["|(%S-)|"] = function(page) -- vim help links
            for _, kind in ipairs({ "hover", "signature" }) do
              local message = require("noice.lsp.docs").get(kind)
              local win = message:win()
              if win ~= nil then
                vim.api.nvim_win_close(win, true) -- Close popup before opening help page
              end
            end
            vim.cmd.help(page) -- Open help page
          end,
        },
      },
      views = {
        split = {
          enter = true, -- Focus split when it open
        },
        cmdline_output = {
          format = {
            "{date} ",
            " ",
            "{title} ",
            "{cmdline} ",
            "{message}",
          },
        },
        cmdline_popup = {
          border = {
            style = "none",
            padding = { 1, 2 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
          position = {
            row = "33%",
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        lsp_doc_border = true, -- Add border to doc popup
        long_message_to_split = true, -- Redirect long message to split view
        cmdline_output_to_split = true, -- Redicect command output to split view
      },
    }
  end,
  keys = {
    { "<leader>snt", "<cmd>Noice telescope<cr>", desc = "Noice telescope" },
  },
}
