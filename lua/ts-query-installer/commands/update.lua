local utils = require "ts-query-installer.utils"

local M = {}

M.update = function(filetype, notify)
  if vim.fn.isdirectory(vim.fs.joinpath(utils.queries_dir, filetype)) == 0 then
    notify("No query installed for filetype " .. filetype, vim.log.levels.WARN)
  end
  vim.loop.spawn("git", {
    args = { "pull" },
    cwd = vim.fs.joinpath(utils.repos_dir, filetype),
  }, function(code)
    vim.schedule(function()
      if code ~= 0 then
        notify("Failed to update query for filetype " .. filetype, vim.log.levels.ERROR)
        return
      end
      notify("Updated query for filetype " .. filetype, vim.log.levels.INFO)
    end)
  end)
end

M.complete = function()
  return vim.list_extend(utils.installed(), { "all" })
end

return M
