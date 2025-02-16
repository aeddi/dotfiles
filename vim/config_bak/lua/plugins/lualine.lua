return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = require("lazyvim.config").icons

    vim.o.laststatus = vim.g.lualine_laststatus

    local fileinfo = function()
      local current_file = vim.api.nvim_buf_get_name(0)
      if vim.fn.filereadable(current_file) == 1 then
        require("utils.popup").popup_cmd({ cmd = "stat", args = { "-x", current_file } }, "File detailled info")
      end
    end

    return {
      options = {
        -- theme = "auto",
        theme = "catppuccin",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },

        lualine_c = {
          vim.tbl_deep_extend("force", LazyVim.lualine.root_dir(), {
            on_click = function(_, _, modifier)
              if vim.trim(modifier) == "s" then
                require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
              else
                require("utils.popup").popup_cmd(
                  { cmd = "tokei", cwd = LazyVim.root.get({ normalize = true }) },
                  "tokei - Code statistics"
                )
              end
            end,
          }),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
            on_click = function(_, _, modifier)
              if vim.trim(modifier) == "s" then
                vim.cmd(":TroubleToggle workspace_diagnostics")
              else
                vim.cmd(":TroubleToggle document_diagnostics")
              end
            end,
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path(), padding = { left = 0 } },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = LazyVim.ui.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = LazyVim.ui.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = LazyVim.ui.fg("Debug"),
          },
          -- stylua: ignore
          {
            function()
              local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
              local other_clients = require("lspconfig.util").get_other_matching_providers(vim.bo.filetype)
              local total = vim.tbl_count(buf_clients) + vim.tbl_count(other_clients)
              return " " .. tostring(vim.tbl_count(buf_clients) .. "/" .. tostring(total))
            end,
            cond = function()
              local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
              local other_clients = require("lspconfig.util").get_other_matching_providers(vim.bo.filetype)
              return vim.tbl_count(buf_clients) + vim.tbl_count(other_clients) > 0
            end,
            color = function()
              if vim.tbl_count(vim.lsp.get_active_clients({ bufnr = 0 })) > 0 then
                return "DiagnosticHint"
              end
              return "DiagnosticWarn"
            end,
            on_click = function () require("lspconfig.ui.lspinfo")() end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = LazyVim.ui.fg("Special"),
            on_click = function() vim.cmd("Lazy") end,
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 }, on_click = fileinfo },
          { "location", separator = " ", padding = { left = 0, right = 1 }, on_click = fileinfo },
          { "selectioncount", padding = { left = 0, right = 1 }, on_click = fileinfo },
        },
        -- stylua: ignore
        lualine_z = { function() return " " .. os.date("%R") end,
        },
      },
      extensions = { "neo-tree", "lazy", "trouble", "man", "mason", "nvim-dap-ui" },
    }
  end,
}
