return {
  "rcarriga/nvim-notify",
  opts = function(_, opts)
    opts.stages = "fade_in_slide_out"
    opts.timeout = 3000
    return opts
  end,
}
