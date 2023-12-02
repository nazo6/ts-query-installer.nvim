local config = require("ts-query-installer.config").config
local utils = require "ts-query-installer.utils"

local M = {}
M.install = function(filetype, notify)
  local source = config.sources[filetype]

  if source == nil then
    notify("No query source found for filetype " .. filetype, vim.log.levels.ERROR)
    return
  end
  if vim.fn.isdirectory(vim.fs.joinpath(utils.queries_dir, filetype)) ~= 0 then
    notify("Query already installed for filetype " .. filetype, vim.log.levels.WARN)
    return
  end

  notify("Installing query for filetype " .. filetype)

  local repo_url = string.starts_with(source.repo, "http") and source.repo or "https://github.com/" .. source.repo
  local repo_clone_path = vim.fs.joinpath(utils.repos_dir, filetype)

  local args
  if vim.fn.isdirectory(repo_clone_path) ~= 0 then
    args = { "pull" }
  else
    args = { "clone", repo_url, repo_clone_path }
    if source.branch then
      vim.list_extend(args, { "--branch", source.branch })
    end
  end

  vim.loop.spawn("git", {
    args = args,
  }, function(code)
    vim.schedule(function()
      if code ~= 0 then
        notify("Failed to install query for filetype " .. filetype, vim.log.levels.ERROR)
        return
      end

      local query_source = vim.fs.joinpath(repo_clone_path, source.path or "queries")
      local query_dest = vim.fs.joinpath(utils.queries_dir, filetype)
      vim.fn.mkdir(query_dest, "p")
      for name, type in vim.fs.dir(query_source) do
        if type == "file" then
          vim.loop.fs_copyfile(vim.fs.joinpath(query_source, name), vim.fs.joinpath(query_dest, name))
        end
      end
      notify("Installed query for filetype " .. filetype, vim.log.levels.INFO)
    end)
  end)
end

M.complete = function()
  return vim.list_extend(utils.not_installed(), { "all" })
end

return M
