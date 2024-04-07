-- Set border on LspInfo windows
require("lspconfig.ui.windows").default_options.border = "rounded"

return {
  "neovim/nvim-lspconfig",
  opts = {
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
    },
  },
}
