---@class tqi.Config
---@field sources tqi.QuerySource<string, tqi.QuerySource>
---
---@class tqi.QuerySource
---@field repo string
---@field branch string|nil
---@field path string|nil @Default is "queries"

local M = {
  ---@type tqi.Config
  config = nil,
}

return M
