-- Set border on LspInfo windows
require("lspconfig.ui.windows").default_options.border = "rounded"

return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              -- Add completion for vim built-in functions
              globals = { "vim" },
            },
          },
        },
      },
      gopls = {
        settings = {
          gopls = {
            analyses = {
              fieldalignment = false,
            },
          },
        },
      },
    },
  },
}
