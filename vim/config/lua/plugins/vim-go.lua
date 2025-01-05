return {
  "fatih/vim-go",
  init = function()
    vim.g.go_code_completion_enabled = 0
    vim.g.go_fmt_autosave = 0
    vim.g.go_imports_autosave = 0
    vim.g.go_mod_fmt_autosave = 0
  end,
}
