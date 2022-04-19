require "paq" {
    "savq/paq-nvim";                  -- Let Paq manage itself
    "nvim-treesitter/nvim-treesitter";
    "neovim/nvim-lspconfig";          -- Mind the semi-colons
    "simrat39/rust-tools.nvim";
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/vim-vsnip";
    "nvim-lua/plenary.nvim";
    "nvim-lua/popup.nvim";
    "nvim-telescope/telescope.nvim";
    "npxbr/gruvbox.nvim";
    "hoob3rt/lualine.nvim";
    "rktjmp/lush.nvim";
    "dylanaraps/wal.vim";
    "github/copilot.vim";
    "lewis6991/gitsigns.nvim";
    "mcchrish/nnn.vim";
    --{"ms-jpq/coq_nvim", branch=coq};
    --{"ms-jpq/coq.artifacts", branch=artifacts};
    {"lervag/vimtex", opt=true};      -- Use braces when passing options
}

-- essentials
vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.relativenumber = false
vim.o.mouse = "a"

-- tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- colorscheme
vim.o.termguicolors = false
vim.o.background = "dark"
vim.cmd([[colorscheme wal]])

-- file finded
require("telescope").setup()

require("lualine").setup()

-- autocompletion
local cmp = require("cmp")
cmp.setup {
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
    },
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "calc" },
        { name = "vsnip" },
        { name = "ultisnips" },
        { name = "luasnip" },
        { name = "nvim_lua" },
    },
}

-- language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require("lspconfig").rust_analyzer.setup{
  capabilities = capabilities,
}
--require("lspconfig").gopls.setup{}
--require("lspconfig").ccls.setup{}
require("lspconfig").pylsp.setup{
    cmd = { "pyls" }
}
require("lspconfig").terraformls.setup{
  capabilities = capabilities,
}
require("lspconfig").tsserver.setup{}
require("lspconfig").cssls.setup {
  capabilities = capabilities,
}
require("lspconfig").html.setup {
  capabilities = capabilities,
}
require("lspconfig").jsonls.setup {
  capabilities = capabilities,
}
require("lspconfig").pylsp.setup {
  capabilities = capabilities,
}
require("lspconfig").yamlls.setup {
  capabilities = capabilities,
}
require("lspconfig").sumneko_lua.setup {
  capabilities = capabilities,
}

require("lspconfig").svelte.setup{}

-- special rust integration
require("rust-tools").setup()

-- syntax highlighting
require("nvim-treesitter.configs").setup{
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

-- copy & paste
"vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap=true })
"vim.api.nvim_set_keymap("n", "<C-c>", '"+yy', { noremap=true })
"vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+pi', { noremap=true })

-- keybindings
"vim.api.nvim_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap=true, silent=true })
"vim.api.nvim_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap=true, silent=true })

-- auto format
vim.cmd("autocmd BufWrite *.rs :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.go :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.scss :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.css :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.html :lua vim.lsp.buf.formatting_sync(nil, 1000)")

-- git integration
require('gitsigns').setup()

-- file finder
require("telescope").setup()

-- fzf in project
vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap=true })

-- nnn conf
-- nnn file browser setup
vim.cmd("let g:nnn#set_default_mappings = 0")
vim.cmd("let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }")
vim.cmd("let g:nnn#action = { 'l': 'edit', 'w': 'split', 'e': 'vsplit' }")

-- nnn search
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>NnnPicker<CR>", { noremap=true })    "set runtimepath^=~/.vim runtimepath+=~/.vim/after
    "let &packpath = &runtimepath
    "source ~/.vimrc"

"require "paq" {
    "savq/paq-nvim";                  -- Let Paq manage itself
    "nvim-treesitter/nvim-treesitter";
    "neovim/nvim-lspconfig";          -- Mind the semi-colons
    "simrat39/rust-tools.nvim";
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/vim-vsnip";
    "nvim-lua/plenary.nvim";
    "nvim-lua/popup.nvim";
    "nvim-telescope/telescope.nvim";
    "npxbr/gruvbox.nvim";
    "hoob3rt/lualine.nvim";
    "rktjmp/lush.nvim";
    "dylanaraps/wal.vim";
    "github/copilot.vim";
    "lewis6991/gitsigns.nvim";
    "mcchrish/nnn.vim";
    --{"ms-jpq/coq_nvim", branch=coq};
    --{"ms-jpq/coq.artifacts", branch=artifacts};
    {"lervag/vimtex", opt=true};      -- Use braces when passing options
}

-- essentials
vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.relativenumber = false
vim.o.mouse = "a"

-- tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
require "paq" {
    "savq/paq-nvim";                  -- Let Paq manage itself
    "nvim-treesitter/nvim-treesitter";
    "neovim/nvim-lspconfig";          -- Mind the semi-colons
    "simrat39/rust-tools.nvim";
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/vim-vsnip";
    "nvim-lua/plenary.nvim";
    "nvim-lua/popup.nvim";
    "nvim-telescope/telescope.nvim";
    "npxbr/gruvbox.nvim";
    "hoob3rt/lualine.nvim";
    "rktjmp/lush.nvim";
    "dylanaraps/wal.vim";
    "github/copilot.vim";
    "lewis6991/gitsigns.nvim";
    "mcchrish/nnn.vim";
    --{"ms-jpq/coq_nvim", branch=coq};
    --{"ms-jpq/coq.artifacts", branch=artifacts};
    {"lervag/vimtex", opt=true};      -- Use braces when passing options
}

-- essentials
vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.relativenumber = false
vim.o.mouse = "a"

-- tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- colorscheme
vim.o.termguicolors = false
vim.o.background = "dark"
vim.cmd([[colorscheme wal]])

-- file finded
require("telescope").setup()

require("lualine").setup()

-- autocompletion
local cmp = require("cmp")
cmp.setup {
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
    },
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "calc" },
        { name = "vsnip" },
        { name = "ultisnips" },
        { name = "luasnip" },
        { name = "nvim_lua" },
    },
}

-- language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require("lspconfig").rust_analyzer.setup{
  capabilities = capabilities,
}
--require("lspconfig").gopls.setup{}
--require("lspconfig").ccls.setup{}
require("lspconfig").pylsp.setup{
    cmd = { "pyls" }
}
require("lspconfig").terraformls.setup{
  capabilities = capabilities,
}
require("lspconfig").tsserver.setup{}
require("lspconfig").cssls.setup {
  capabilities = capabilities,
}
require("lspconfig").html.setup {
  capabilities = capabilities,
}
require("lspconfig").jsonls.setup {
  capabilities = capabilities,
}
require("lspconfig").pylsp.setup {
  capabilities = capabilities,
}
require("lspconfig").yamlls.setup {
  capabilities = capabilities,
}
require("lspconfig").sumneko_lua.setup {
  capabilities = capabilities,
}

require("lspconfig").svelte.setup{}

-- special rust integration
require("rust-tools").setup()

-- syntax highlighting
require("nvim-treesitter.configs").setup{
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

-- copy & paste
"vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap=true })
"vim.api.nvim_set_keymap("n", "<C-c>", '"+yy', { noremap=true })
"vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+pi', { noremap=true })

-- keybindings
"vim.api.nvim_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap=true, silent=true })
"vim.api.nvim_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap=true, silent=true })

-- auto format
vim.cmd("autocmd BufWrite *.rs :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.go :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.scss :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.css :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.html :lua vim.lsp.buf.formatting_sync(nil, 1000)")

-- git integration
require('gitsigns').setup()

-- file finder
require("telescope").setup()

-- fzf in project
vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap=true })

-- nnn conf
-- nnn file browser setup
vim.cmd("let g:nnn#set_default_mappings = 0")
vim.cmd("let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }")
vim.cmd("let g:nnn#action = { 'l': 'edit', 'w': 'split', 'e': 'vsplit' }")

-- nnn search
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>NnnPicker<CR>", { noremap=true })
-- colorscheme
vim.o.termguicolors = false
vim.o.background = "dark"
vim.cmd([[colorsheme wal]])

-- file finded
require("telescope").setup()

require("lualine").setup()

-- autocompletion
local cmp = require("cmp")
cmp.setup {
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
    },
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "calc" },
        { name = "vsnip" },
        { name = "ultisnips" },
        { name = "luasnip" },
        { name = "nvim_lua" },
    },
}

-- language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require("lspconfig").rust_analyzer.setup{
  capabilities = capabilities,
}
--require("lspconfig").gopls.setup{}
--require("lspconfig").ccls.setup{}
require("lspconfig").pylsp.setup{
    cmd = { "pyls" }
}
require("lspconfig").terraformls.setup{
  capabilities = capabilities,
}
require("lspconfig").tsserver.setup{}
require("lspconfig").cssls.setup {
  capabilities = capabilities,
}
require("lspconfig").html.setup {
  capabilities = capabilities,
}
require("lspconfig").jsonls.setup {
  capabilities = capabilities,
}
require("lspconfig").pylsp.setup {
  capabilities = capabilities,
}
require("lspconfig").yamlls.setup {
  capabilities = capabilities,
}
require("lspconfig").sumneko_lua.setup {
  capabilities = capabilities,
}

require("lspconfig").svelte.setup{}

-- special rust integration
require("rust-tools").setup()

-- syntax highlighting
require("nvim-treesitter.configs").setup{
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

-- copy & paste
"vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap=true })
"vim.api.nvim_set_keymap("n", "<C-c>", '"+yy', { noremap=true })
"vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+pi', { noremap=true })

-- keybindings
"vim.api.nvim_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap=true, silent=true })
"vim.api.nvim_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap=true, silent=true })

-- auto format
vim.cmd("autocmd BufWrite *.rs :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.go :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.scss :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.css :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.html :lua vim.lsp.buf.formatting_sync(nil, 1000)")

-- git integration
require('gitsigns').setup()

-- file finder
require("telescope").setup()

-- fzf in project
vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap=true })

-- nnn conf
-- nnn file browser setup
vim.cmd("let g:nnn#set_default_mappings = 0")
vim.cmd("let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }")
vim.cmd("let g:nnn#action = { 'l': 'edit', 'w': 'split', 'e': 'vsplit' }")

-- nnn search
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>NnnPicker<CR>", { noremap=true })c
