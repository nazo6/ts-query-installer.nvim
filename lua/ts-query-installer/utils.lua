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

return M
