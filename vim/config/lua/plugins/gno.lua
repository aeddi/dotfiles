-- .config/nvim/lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, _)
      -- Add filetype
      vim.filetype.add({
        extension = { gno = "gno" },
      })

      -- Set Go Treesitter parser for Gno
      vim.treesitter.language.register("go", "gno")

      -- Set commentstring for Gno files
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("add_gno_comment_string", { clear = true }),
        pattern = { "gno" },
        callback = function()
          vim.opt.commentstring = "// %s"
        end,
      })

      -- Setup Gnopls (Gno Language Server)
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      if not configs.gnopls then
        configs.gnopls = {
          default_config = {
            cmd = { "gnopls" },
            filetypes = { "gno" },
            root_dir = lspconfig.util.root_pattern("gnomod.toml", "gno.mod", ".git"),
            settings = {},
          },
        }
      end
      lspconfig.gnopls.setup({})
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      -- Set formatters for Gno files
      formatters_by_ft = {
        gno = { "goimports", "gofumpt" },
      },
    },
  },
}
