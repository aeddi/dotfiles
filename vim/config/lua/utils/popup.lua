local M = {}
local Popup = require("nui.popup")
local Text = require("nui.text")
local Event = require("nui.utils.autocmd").event
local Utils = require("nui.utils")
local Job = require("plenary.job")
local Async = require("plenary.async")
local Ansi = require("baleia").setup()

---@class CmdOptions
---@field cmd string
---@field args? string[]
---@field cwd? string
---@field env? table<string, string>

-- Opens a popup containing the cmd output
---@param cmd CmdOptions
---@param title? string
function M.popup_cmd(cmd, title)
  local stderr, stdout = {}, {}

  local handle_cmd_result = function(code)
    Async.util.scheduler(function()
      if code == 0 then
        M.popup(stdout, title)
      else
        local err = ""
        for _, line in ipairs(stderr) do
          err = err .. line .. "\n"
        end
        err = err .. "exit code " .. tostring(code) .. "\n"
        vim.notify(err, "error", { title = title })
      end
    end)
  end

  local job = Job:new({
    command = cmd.cmd,
    args = cmd.args,
    cwd = cmd.cwd,
    env = cmd.env,
    on_stderr = function(_, data)
      table.insert(stderr, data)
    end,
    on_stdout = function(_, data)
      table.insert(stdout, data)
    end,
    on_exit = function(_, code, _)
      handle_cmd_result(code)
    end,
  })

  local success, err = pcall(function()
    job:start()
  end)

  if not success then
    vim.notify(err, "error", { title = title })
  end
end

local function get_longest(content)
  local stripped = require("baleia.text").content({ strip_ansi_codes = true }, content)
  local max, curr = 0, 0
  for _, line in ipairs(stripped) do
    curr = vim.fn.strdisplaywidth(line)
    if curr > max then
      max = curr
    end
  end
  return max
end

-- Opens a popup
---@param content string[]
---@param title? string
function M.popup(content, title)
  local content_width = get_longest(content)
  local content_height = #content

  local editor_size = Utils.get_editor_size()
  local max_width = math.floor(editor_size.width * 80 / 100 + 0.5)
  local max_height = math.floor(editor_size.height * 80 / 100 + 0.5)

  local popup_width, popup_height = content_width, content_height
  if popup_width > max_width then
    popup_width = max_width
  end
  if popup_height > max_height then
    popup_height = max_height
  end

  local ptitle = nil
  if title ~= nil then
    ptitle = {
      top = Text(" " .. title .. " ", "FloatBorder"),
      top_align = "center",
    }
  end

  local popup = Popup({
    position = "50%",
    size = {
      width = popup_width,
      height = popup_height,
    },
    enter = true,
    focusable = true,
    relative = "editor",
    border = {
      style = "rounded",
      padding = { top = 1, bottom = 1, left = 3, right = 3 },
      text = ptitle,
    },
    buf_options = {
      modifiable = false,
      readonly = true,
    },
    win_options = { winblend = 10, winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
  })

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, true, content)
  vim.bo[popup.bufnr].filetype = "CustomPopup"

  popup:map("n", "q", function()
    popup:unmount()
  end, { noremap = true })

  popup:on(Event.BufLeave, function()
    popup:unmount()
  end)

  popup:on(Event.BufWinEnter, function()
    vim.opt_local.scrolloff = 0
    vim.opt_local.sidescrolloff = 0
  end)

  Ansi.once(popup.bufnr)
  popup:mount()
end

return M
