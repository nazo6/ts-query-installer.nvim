local config = require("ts-query-installer.config").config

local M = {}

local function get_package_path()
  local source = string.sub(debug.getinfo(1, "S").source, 2)
  return vim.fn.fnamemodify(source, ":p:h:h:h")
end

M.repos_dir = vim.fs.joinpath(get_package_path(), "repos")
M.queries_dir = vim.fs.joinpath(get_package_path(), "queries")

string.starts_with = function(str, start)
  return str:sub(1, #start) == start
end

M.installed = function()
  local queries_dir = require("ts-query-installer.utils").queries_dir
  local query_names = {}
  for name, type in vim.fs.dir(queries_dir) do
    if type == "directory" then
      table.insert(query_names, name)
    end
  end
  return query_names
end

M.not_installed = function()
  local installed = M.installed()
  return vim
    .iter(vim.tbl_keys(config.sources))
    :filter(function(filetype)
      return not vim.tbl_contains(installed, filetype)
    end)
    :totable()
end

return M
