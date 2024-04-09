-- Enable mouse event for scrollbar hover highlight
vim.opt.mousemoveevent = true

-- Customize colors of scrollbar
vim.api.nvim_set_hl(0, "ScrollView", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "ScrollViewHover", { link = "PmenuSel" })

return {
  "dstein64/nvim-scrollview",
  opts = {
    -- Display scrollbar only on current buffer
    current_only = true,

    -- Customize signs on scrollbar
    signs_on_startup = { "all" },
    diagnostics_error_symbol = "-",
    diagnostics_warn_symbol = "-",
    diagnostics_info_symbol = "-",
    diagnostics_hint_symbol = "-",
    diagnostics_severities = {
      vim.diagnostic.severity.ERROR,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.HINT,
    },
  },
}
