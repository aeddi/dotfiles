return {
  "nvimdev/dashboard-nvim",
  opts = function()
    -- Copied from https://github.com/nvimdev/dashboard-nvim/blob/master/lua/dashboard/theme/header.lua
    local ascii_weekdays = {
      ["Monday"] = {
        "",
        "███╗   ███╗ ██████╗ ███╗   ██╗██████╗  █████╗ ██╗   ██╗",
        "████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝",
        "██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ ",
        "██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  ",
        "██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   ",
        "╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
        "",
      },
      ["Tuesday"] = {
        "",
        "████████╗██╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗",
        "╚══██╔══╝██║   ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝",
        "   ██║   ██║   ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝ ",
        "   ██║   ██║   ██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝  ",
        "   ██║   ╚██████╔╝███████╗███████║██████╔╝██║  ██║   ██║   ",
        "   ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
        "",
      },
      ["Wednesday"] = {
        "",
        "██╗    ██╗███████╗██████╗ ███╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗",
        "██║    ██║██╔════╝██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝",
        "██║ █╗ ██║█████╗  ██║  ██║██╔██╗ ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝ ",
        "██║███╗██║██╔══╝  ██║  ██║██║╚██╗██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝  ",
        "╚███╔███╔╝███████╗██████╔╝██║ ╚████║███████╗███████║██████╔╝██║  ██║   ██║   ",
        " ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
        "",
      },
      ["Thursday"] = {
        "",
        "████████╗██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  █████╗ ██╗   ██╗",
        "╚══██╔══╝██║  ██║██║   ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝",
        "   ██║   ███████║██║   ██║██████╔╝███████╗██║  ██║███████║ ╚████╔╝ ",
        "   ██║   ██╔══██║██║   ██║██╔══██╗╚════██║██║  ██║██╔══██║  ╚██╔╝  ",
        "   ██║   ██║  ██║╚██████╔╝██║  ██║███████║██████╔╝██║  ██║   ██║   ",
        "   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
        "",
      },
      ["Friday"] = {
        "",
        "███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗",
        "██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝",
        "█████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝ ",
        "██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝  ",
        "██║     ██║  ██║██║██████╔╝██║  ██║   ██║   ",
        "╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
        "",
      },
      ["Saturday"] = {
        "",
        "███████╗ █████╗ ████████╗██╗   ██╗██████╗ ██████╗  █████╗ ██╗   ██╗",
        "██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝",
        "███████╗███████║   ██║   ██║   ██║██████╔╝██║  ██║███████║ ╚████╔╝ ",
        "╚════██║██╔══██║   ██║   ██║   ██║██╔══██╗██║  ██║██╔══██║  ╚██╔╝  ",
        "███████║██║  ██║   ██║   ╚██████╔╝██║  ██║██████╔╝██║  ██║   ██║   ",
        "╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
        "",
      },
      ["Sunday"] = {
        "",
        "███████╗██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗",
        "██╔════╝██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝",
        "███████╗██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ ",
        "╚════██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  ",
        "███████║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   ",
        "╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ",
        "",
      },
    }

    local function generate_date_header()
      local weekdays = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
      local ascii_weekday = ascii_weekdays[weekdays[os.date("*t").wday]]
      return vim.list_extend(ascii_weekday, { os.date(" %d %B %Y    %H:%M"), "", "" })
    end

    local function edit_config()
      return LazyVim.telescope("find_files", { cwd = vim.fn.stdpath("config") .. "/lua" })
    end

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = {},
        -- stylua: ignore
        center = {
          { action = LazyVim.telescope("files"),          desc = " Find File",       icon = " ", key = "f" },
          { action = "ene | startinsert",                 desc = " New File",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                desc = " Recent Files",    icon = " ", key = "r" },
          { action = "Telescope projects",                desc = " Projects",        icon = " ", key = "p" },
          { action = "Telescope live_grep",               desc = " Find Text",       icon = " ", key = "g" },
          { action = edit_config(),                       desc = " Configuration",   icon = " ", key = "c" },
          { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          { action = "Lazy",                              desc = " Plugins",         icon = " ", key = "l" },
          { action = "qa",                                desc = " Quit",            icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }
    LazyVim.telescope.config_files()

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    local header = generate_date_header()
    local content_size = vim.tbl_count(header) + (vim.tbl_count(opts.config.center) * 2) + 1
    local spaces_before = math.floor((vim.api.nvim_win_get_height(0) - content_size) / 2)

    opts.config.header = vim.list_extend(vim.split(string.rep("\n", spaces_before), "\n"), header)

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "dashboard" },
      callback = function()
        vim.b.minianimate_disable = true
      end,
    })

    return opts
  end,
}
