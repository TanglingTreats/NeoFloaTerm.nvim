vim.g.is_term_open = false
local NeoFloatTerm = {}

function NeoFloatTerm:test_func()
  return "test"
end

function NeoFloatTerm:new()
  -- init defaults
  local term_defaults = { config = nil }
  return setmetatable(term_defaults, { __index = self })
end

function NeoFloatTerm:setup(config)
  -- Set config variables for floating terminal
  self.config = config
end

function NeoFloatTerm:create()
end

function NeoFloatTerm:destroy()
end

function NeoFloatTerm:open()
  if vim.g.is_term_open then
    local i = vim.api.nvim_win_get_buf(0)
    print(i)
    while (i >= 1)
    do
      print(vim.bo.filetype)
      --if vim.api'getbufvar(i, "&buftype")') == "terminal" then
      --vim.cmd('silent exe "bdelete! " . i')
      --end
      i = i - 1
    end
    vim.g.is_term_open = false
  else
    vim.g.is_term_open = true

    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    -- Calculate window width and height
    if (width > 150 or height > 35) then
      local win_height = math.min(math.ceil(height * 3 / 4), 30)
      local win_width

      if (width < 150) then
        win_width = math.ceil(width - 8)
      else
        win_width = math.ceil(width * 0.9)
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

      local win_opts = {
        relative = 'editor',
        width = win_width,
        height = win_height,
        row = math.ceil((height - win_height) / 2),
        col = math.ceil((width - win_width) / 2)
      }
      local win = vim.api.nvim_open_win(buf, false, win_opts);
      local chan = vim.api.nvim_open_term(buf, {})
      vim.api.nvim_chan_send(chan)
    end
  end
end

function NeoFloatTerm:close()
end

function NeoFloatTerm:toggle()
end

return NeoFloatTerm
