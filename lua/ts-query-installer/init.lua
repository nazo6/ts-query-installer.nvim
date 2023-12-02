local c = require "ts-query-installer.config"

local M = {}

M.setup = function(config)
  if c.config ~= nil then
    return
  end
  c.config = config

  require("ts-query-installer.commands").setup()
end

return M
