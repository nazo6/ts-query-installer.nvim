# ts-query-installer.nvim

Plugin to install external treesitter query that is not included in
nvim-treesitter.

Be aware that external "parser" can be installed by nvim-treesitter itself. This
plugin is for external "query".

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

and specify as dependency of `nvim-treesitter`

```lua
{
  "nvim-treesitter/nvim-treesitter",
  ...
  dependencies = {
    ...
    { "ts-query-installer.nvim" },
  },
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
