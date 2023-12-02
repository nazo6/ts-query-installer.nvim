local utils = require "ts-query-installer.utils"

local create_notify = function(idx, all)
  local notify = function(msg, level, opts)
    local new_msg = string.format("[%d/%d]", idx, all) .. " " .. msg
    local new_opts = vim.tbl_extend("keep", opts or {}, { title = "TSQueryInstaller" })
    vim.notify(new_msg, level, new_opts)
  end
  return notify
end

local setup_install = function()
  local action = require "ts-query-installer.commands.install"
  vim.api.nvim_create_user_command("TSQueryInstall", function(params)
    local filetypes = params.fargs

    if params.fargs[1] == "all" then
      local not_installed = utils.not_installed()
      vim.notify("Installing all " .. #not_installed .. " queries", vim.log.levels.INFO, { title = "TSQueryInstaller" })
      filetypes = not_installed
    end

    for idx, filetype in ipairs(filetypes) do
      action.install(filetype, create_notify(idx, #filetypes))
    end
  end, {
    desc = "Install treesitter query",
    nargs = "+",
    complete = action.complete,
  })
end

local setup_uninstall = function()
  local action = require "ts-query-installer.commands.uninstall"
  vim.api.nvim_create_user_command("TSQueryUninstall", function(params)
    local filetypes = params.fargs
    if params.fargs[1] == "all" then
      local installed = utils.installed()
      vim.notify("Uninstalling all " .. #installed .. " queries", vim.log.levels.INFO, { title = "TSQueryInstaller" })
      filetypes = installed
    end

    for idx, filetype in ipairs(filetypes) do
      action.uninstall(filetype, create_notify(idx, #filetypes))
    end
  end, {
    desc = "Uninstall treesitter query",
    nargs = "+",
    complete = action.complete,
  })
end

local setup_update = function()
  local action = require "ts-query-installer.commands.update"
  vim.api.nvim_create_user_command("TSQueryUpdate", function(params)
    local filetypes = params.fargs
    if params.fargs[1] == "all" then
      local installed = utils.installed()
      vim.notify("Updating all " .. #installed .. " queries", vim.log.levels.INFO, { title = "TSQueryInstaller" })
      filetypes = installed
    end

    for idx, filetype in ipairs(filetypes) do
      action.update(filetype, create_notify(idx, #filetypes))
    end
  end, {
    desc = "Update treesitter query",
    nargs = "+",
    complete = action.complete,
  })
end

return {
  setup = function()
    setup_install()
    setup_uninstall()
    setup_update()
  end,
}
