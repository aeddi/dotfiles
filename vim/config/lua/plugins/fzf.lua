return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    opts.files.no_header = true
    opts.files.no_header_i = true
    opts.grep.no_header = true
    opts.grep.no_header_i = true
  end,
}
