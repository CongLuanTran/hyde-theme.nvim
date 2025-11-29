# hyde-theme.nvim

This is an automatic theme detection intended for [HyDE](https://github.com/HyDE-Project/HyDE),
a dotfile repo for Hyprland on Arch.

## How this works

This plugin basically map your system's GTK theme, which HyDE will set, to a
Neovim theme. It is not intended to work in isolation, you must have HyDE or
some other ways to change your system GTK theme. It will not try to set the
colorscheme itself due to the complexity of colorscheme intergration in Neovim.

The definition of the colorscheme itself is not shipped with the plugins, you
will have to import their plugin yourself. Below is the default mapping of
default HyDE themes to neovim colorscheme plugins:

- Catpuccin (Mocha/Latte): [catpuccin/nvim](https://github.com/catppuccin/nvim)
- Rose Pine/Material Sakura: [rose-pine/nvim](https://github.com/rose-pine/neovim)
- Tokyo Night: [tokyonight.nvim (storm flavour)](https://github.com/folke/tokyonight.nvim)
- Gruvbox Retro: [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)
- Frosted Glass: [modus-themes.nvim](https://github.com/miikanissi/modus-themes.nvim)
- Nordic Blue: [nightfox (nordfox flavour)](https://github.com/EdenEast/nightfox.nvim)
- The rest: I haven't decied yet

You can also set your own mapping and your default theme in `opts`. If there is
no suitable mapping, Neovim's `default` scheme will be used.

## Installation

IMPORTANT: the plugin doesn't set the theme for you, it just returns the name of that theme.
You will have to change the theme manually.

Use your preferred plugin manager, for example, with lazy.nvim:

```lua
return {
  { 'catppuccin/nvim', name = 'catppuccin' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'folke/tokyonight.nvim', opts = {} },
  { 'EdenEast/nightfox.nvim' },
  { 'ellisonleao/gruvbox.nvim', opts = {} },
  { 'miikanissi/modus-themes.nvim' },
  --- More colorscheme if you wish
  {
    "CongLuanTran/hyde-theme.nvim",
    opts = {
      -- It is possible to set your own default theme.
      -- For example, "astrotheme" if your use AstroNvim
      -- default = "astrotheme"
      -- Optionally override theme mapping or add new mapping here
      -- ["Tokyo-Night"] = "tokyonight-moon"
      -- ["Your-GTK-Theme"] = "your-colorscheme"
    },
    config = function(_, opts)
      local hyde = require("hyde_theme")
      hyde.setup(opts)
      local theme = hyde.detect_theme()
      vim.cmd.colorscheme(theme)
    end,
  }
}
```
