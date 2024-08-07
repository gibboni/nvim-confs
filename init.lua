local Plug = require 'usermod.vimplug'
local plugin_path = vim.fn.stdpath('data') .. '/plugged'

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

Plug.begin(plugin_path)
Plug ('tpope/vim-fugitive')
Plug ('catppuccin/nvim', {as= 'catppuccin'})
Plug ('nvim-lualine/lualine.nvim')
Plug ('kyazdani42/nvim-web-devicons')
Plug ('nvim-zh/better-escape.vim')
Plug ('rcarriga/nvim-notify')
Plug ('neovim/nvim-lspconfig')
Plug ('hrsh7th/nvim-cmp')
Plug ('hrsh7th/cmp-nvim-lsp')
Plug ('saadparwaiz1/cmp_luasnip')
Plug ('L3MON4D3/LuaSnip')
Plug ('folke/lsp-colors.nvim')
Plug ('folke/trouble.nvim')
Plug ('farmergreg/vim-lastplace')
Plug ('nvim-treesitter/nvim-treesitter')
Plug ('mg979/vim-visual-multi')
Plug.ends()

vim.opt.termguicolors = true
vim.opt.number = true
vim.g.mapleader = "."
vim.opt.encoding="utf-8"
vim.opt.wrap = true
vim.opt.linebreak=true
vim.opt.textwidth=0
vim.opt.wrapmargin=0
vim.cmd('set formatoptions-=t')
vim.opt.cmdheight=2
vim.opt.showmode=false
vim.cmd('colorscheme catppuccin')
vim.opt.hidden=true

require('usermod.keymappings')

vim.notify = require("notify")
require('lualine').setup()
-- Trouble setup + keys
require('trouble').setup {
modes = {
    preview_float = {
      mode = "diagnostics",
      auto_open = true,
      auto_close = false,
      preview = {
        type = "float",
        relative = "editor",
        border = "rounded",
        title = "Preview",
        title_pos = "center",
        position = { 0, -2 },
        size = { width = 0.3, height = 0.3 },
        zindex = 200,
      },
    },
  },
}

-- luasnip setup
local luasnip = require 'luasnip'

-- lastplace
vim.g.lastplace_ignore_buftype = "quickfix,nofile,help"
vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"

-- lsp configs
require('usermod.lspconfs')

-- Neovide, if used
--if vim.g.neovide then
vim.o.guifont = "Iosevka Nerd Font Mono:h14"
--end

