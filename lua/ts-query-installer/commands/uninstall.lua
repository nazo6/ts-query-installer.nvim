local utils = require "ts-query-installer.utils"

local M = function(filetype)
  if vim.fn.isdirectory(vim.fs.joinpath(utils.queries_dir, filetype)) == 0 then
    vim.notify("No query installed for filetype " .. filetype)
  end
  vim.fn.delete(vim.fs.joinpath(utils.queries_dir, filetype), "rf")
  vim.fn.delete(vim.fs.joinpath(utils.repos_dir, filetype), "rf")
  vim.notify("Uninstalled query for filetype " .. filetype)
end

return M
