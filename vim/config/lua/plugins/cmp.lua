-- Luasnip choice node copied from https://github.com/L3MON4D3/LuaSnip/wiki/Misc#choicenode-popup
local current_nsid = vim.api.nvim_create_namespace("LuaSnipChoiceListSelections")
local current_win = nil

local function window_for_choiceNode(choiceNode)
  local buf = vim.api.nvim_create_buf(false, true)
  local buf_text = {}
  local row_selection = 0
  local row_offset = 0
  local text
  for _, node in ipairs(choiceNode.choices) do
    text = node:get_docstring()
    -- find one that is currently showing
    if node == choiceNode.active_choice then
      -- current line is starter from buffer list which is length usually
      row_selection = #buf_text
      -- finding how many lines total within a choice selection
      row_offset = #text
    end
    vim.list_extend(buf_text, text)
  end

  vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, buf_text)
  local w, h = vim.lsp.util._make_floating_popup_size(buf_text, {})

  -- adding highlight so we can see which one is been selected.
  local extmark = vim.api.nvim_buf_set_extmark(
    buf,
    current_nsid,
    row_selection,
    0,
    { hl_group = "incsearch", end_line = row_selection + row_offset }
  )

  -- shows window at a beginning of choiceNode.
  local win = vim.api.nvim_open_win(buf, false, {
    relative = "win",
    width = w,
    height = h,
    bufpos = choiceNode.mark:pos_begin_end(),
    style = "minimal",
    border = "rounded",
  })

  -- return with 3 main important so we can use them again
  return { win_id = win, extmark = extmark, buf = buf }
end

function choice_popup(choiceNode)
  -- build stack for nested choiceNodes.
  if current_win then
    vim.api.nvim_win_close(current_win.win_id, true)
    vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  end
  local create_win = window_for_choiceNode(choiceNode)
  current_win = {
    win_id = create_win.win_id,
    prev = current_win,
    node = choiceNode,
    extmark = create_win.extmark,
    buf = create_win.buf,
  }
end

function update_choice_popup(choiceNode)
  if current_win ~= nil then
    vim.api.nvim_win_close(current_win.win_id, true)
    vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
    local create_win = window_for_choiceNode(choiceNode)
    current_win.win_id = create_win.win_id
    current_win.extmark = create_win.extmark
    current_win.buf = create_win.buf
  end
end

function choice_popup_close()
  if current_win ~= nil then
    vim.api.nvim_win_close(current_win.win_id, true)
    vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
    -- now we are checking if we still have previous choice we were in after exit nested choice
    current_win = current_win.prev
    if current_win then
      -- reopen window further down in the stack.
      local create_win = window_for_choiceNode(current_win.node)
      current_win.win_id = create_win.win_id
      current_win.extmark = create_win.extmark
      current_win.buf = create_win.buf
    end
  end
end

vim.cmd([[
augroup choice_popup
au!
au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
au User LuasnipChoiceNodeLeave lua choice_popup_close()
au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
augroup END
]])

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdLineEnter" },
  dependencies = {
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "davidsierradz/cmp-conventionalcommits",
    "L3MON4D3/LuaSnip",
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- Insert / Select modes mapping
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.choice_active() then
          luasnip.change_choice(1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-k>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.choice_active() then
          luasnip.change_choice(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-h>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.abort()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-l>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-b>"] = cmp.mapping(function(fallback)
        if cmp.visible_docs() then
          cmp.scroll_docs(-4)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-f>"] = cmp.mapping(function(fallback)
        if cmp.visible_docs() then
          cmp.scroll_docs(4)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    -- Command mode mapping
    local cmd_mapping = cmp.mapping.preset.cmdline({
      ["<C-j>"] = {
        c = function(_)
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end,
      },
      ["<C-k>"] = {
        c = function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
          end
        end,
      },
      ["<C-l>"] = {
        c = function()
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            cmp.complete()
          end
        end,
      },
      ["<C-h>"] = { c = cmp.mapping.abort() },
      ["<C-f>"] = { c = function() end }, -- Disable command line history
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmd_mapping,
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
    -- `/` and `?` cmdline setup.
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmd_mapping,
      sources = {
        { name = "buffer" },
      },
    })
    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "conventionalcommits" },
      }, {
        { name = "buffer" },
      }),
    })

    -- Add border on completion and documentation windows
    if opts.window == nil then
      opts.window = {}
    end
    opts.window.completion = cmp.config.window.bordered()
    opts.window.documentation = cmp.config.window.bordered()
  end,
}
