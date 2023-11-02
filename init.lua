local Plug = require 'usermod.vimplug'
local plugin_path = vim.fn.stdpath('data') .. '/plugged'
local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

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
Plug ('vimwiki/vimwiki')
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

vim.g.better_escape_interval = 200
vim.g.better_escape_shortcut = 'jk'

vim.notify = require("notify")
require('lualine').setup()
-- Trouble setup + keys
require('trouble').setup {
	position = "right",
	auto_open = true,
	auto_close = false
}
-- require'lspconfig'.gopls.setup{}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls','pylsp' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- lastplace
vim.g.lastplace_ignore_buftype = "quickfix,nofile,help"
vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
