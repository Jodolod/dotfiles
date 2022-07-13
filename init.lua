-- packages
require "paq" {
	"savq/paq-nvim";
	"nvim-treesitter/nvim-treesitter";
	"neovim/nvim-lspconfig";
  "simrat39/rust-tools.nvim";
  "hrsh7th/nvim-cmp";
  "hrsh7th/cmp-buffer";
  "hrsh7th/cmp-nvim-lsp";
  "hrsh7th/vim-vsnip";
  "nvim-lualine/lualine.nvim";
  "kyazdani42/nvim-web-devicons";
	"rktjmp/lush.nvim";
	"npxbr/gruvbox.nvim";
	"nvim-lua/popup.nvim";
	"nvim-lua/plenary.nvim";
	"nvim-telescope/telescope.nvim";
  "lewis6991/gitsigns.nvim";
  "mcchrish/nnn.vim";
  "tpope/vim-fugitive";
}

-- essentials
vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"

-- tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.cmd("autocmd FileType svelte,xml,html,xhtml,lua,yaml,terraform setlocal shiftwidth=2 tabstop=2")

-- colorscheme
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- statusbar
require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'}, -- , 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- git integration
require('gitsigns').setup()

-- file finder
require("telescope").setup()

-- autocompletion
local cmp = require("cmp")
cmp.setup {
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
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
require("lspconfig").gopls.setup{}
require("lspconfig").ccls.setup{}
require("lspconfig").r_language_server.setup{}
require("lspconfig").pylsp.setup{
    cmd = { "pyls" }
}
require("lspconfig").ansiblels.setup{}
require("lspconfig").terraformls.setup{
  capabilities = capabilities,
}
require("lspconfig").tsserver.setup{}
require("lspconfig").svelte.setup{}
require("lspconfig").tailwindcss.setup{}
require("lspconfig").cssls.setup {
  capabilities = capabilities,
}
require("lspconfig").html.setup {
  capabilities = capabilities,
}

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

-- increase numbers
vim.api.nvim_set_keymap("n", "<C-y>", "<C-a>", { noremap=true })

-- copy & paste
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap=true })
vim.api.nvim_set_keymap("n", "<C-c>", '"+yy', { noremap=true })
vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+pi', { noremap=true })

-- nnn file browser setup
vim.cmd("let g:nnn#set_default_mappings = 0")
vim.cmd("let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }")
vim.cmd("let g:nnn#action = { 'l': 'edit', 'w': 'split', 'e': 'vsplit' }")

-- keybindings
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>NnnPicker<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap=true, silent=true })

vim.api.nvim_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setqflist()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>k", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>j", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<space>r", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap=true, silent=true })

-- Git Navigation
vim.api.nvim_set_keymap("n", "<space>hj", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true, noremap=true})
vim.api.nvim_set_keymap("n", "<space>hk", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true, noremap=true})
vim.api.nvim_set_keymap("n", "<space>hl", "<cmd>Gitsigns setqflist<CR>", { noremap=true })

-- Git Actions
vim.api.nvim_set_keymap("n", "<space>hs", "<cmd>Gitsigns stage_hunk<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "<space>hr", "<cmd>Gitsigns reset_hunk<CR>", { noremap=true })

vim.api.nvim_set_keymap("n", "<space>hS", "<cmd>lua package.loaded.gitsigns.stage_buffer()<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "<space>hu", "<cmd>lua package.loaded.gitsigns.undo_stage_hunk()<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "<space>hR", "<cmd>lua package.loaded.gitsigns.reset_buffer()<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "<space>hp", "<cmd>lua package.loaded.gitsigns.preview_hunk()<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "<space>hb", "<cmd>lua package.loaded.gitsigns.blame_line{full=true}<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "<space>tb", "<cmd>lua package.loaded.gitsigns.toggle_current_line_blame()<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "<space>hd", "<cmd>lua package.loaded.gitsigns.diffthis()<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "<space>hD", "<cmd>lua package.loaded.gitsigns.diffthis('~')<CR>", { noremap=true })
vim.api.nvim_set_keymap("n", "<space>td", "<cmd>lua package.loaded.gitsigns.toggle_deleted()<CR>", { noremap=true })

-- auto format
vim.cmd("autocmd BufWrite *.rs :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.go :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.scss :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.css :lua vim.lsp.buf.formatting_sync(nil, 1000)")
vim.cmd("autocmd BufWrite *.html :lua vim.lsp.buf.formatting_sync(nil, 1000)")


