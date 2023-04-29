local status, Terminal = pcall(require, 'NeoFloaTerm/floaterm')
if not status then return end

local M = {}

local t = Terminal:new()
if t == nil then return end


function M.setup(config)
  t:setup(config)
end

function M.test_func()
  print(t:test_func())
end

return M
