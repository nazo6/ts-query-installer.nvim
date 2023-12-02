local utils = require "ts-query-installer.utils"

local M = {}

M.uninstall = function(filetype, notify)
  if vim.fn.isdirectory(vim.fs.joinpath(utils.queries_dir, filetype)) == 0 then
    notify("No query installed for filetype " .. filetype, vim.log.levels.WARN)
  end
  vim.fn.delete(vim.fs.joinpath(utils.queries_dir, filetype), "rf")
  vim.fn.delete(vim.fs.joinpath(utils.repos_dir, filetype), "rf")
  notify("Uninstalled query for filetype " .. filetype, vim.log.levels.INFO)
end

M.complete = function()
  return vim.list_extend(utils.installed(), { "all" })
end

return M
