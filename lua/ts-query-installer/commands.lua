local setup_install = function()
  vim.api.nvim_create_user_command("TSQueryInstall", function(params)
    for _, filetype in ipairs(params.fargs) do
      require "ts-query-installer.commands.install"(filetype)
    end
  end, {
    desc = "Install treesitter query",
    nargs = "+",
  })
end

local setup_uninstall = function()
  vim.api.nvim_create_user_command("TSQueryUninstall", function(params)
    for _, filetype in ipairs(params.fargs) do
      require "ts-query-installer.commands.uninstall"(filetype)
    end
  end, {
    desc = "Uninstall treesitter query",
    nargs = "+",
  })
end

return {
  setup = function()
    setup_install()
    setup_uninstall()
  end,
}
