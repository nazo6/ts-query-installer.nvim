# ts-query-installer.nvim

Plugin to install external treesitter query that is not included in
nvim-treesitter.

Be aware that external "scanner" can be installed by nvim-treesitter itself.
This plugin is for external "query".

# Installation

Using lazy.nvim :

```lua
{
  "nazo6/ts-query-installer.nvim",
  config = function()
    require("ts-query-installer").setup {
      sources = {
        -- "nu" is the name of the filetype.
        nu = {
          -- Only "repo" is required.
          repo = "https://github.com/nushell/tree-sitter-nu",
          branch = "main",
          path = "queries",
        },
      },
    }
  end,
}
```

# Usage

## Install query

```vim
:TSQueryInstall <filetype>
" or install all
:TSQueryInstall all
```

## Update query

```vim
:TSQueryUpdate <filetype>
" or update all
:TSQueryUpdate all
```

## Uninstall query

```vim
:TSQueryUninstall <filetype>
" or uninstall all
:TSQueryUninstall all
```
