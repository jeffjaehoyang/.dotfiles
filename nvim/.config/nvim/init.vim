" (N)Vim Configuration File

" i need a way to differentiate between work and personal env
let g:username = $USER
let g:machine_env = "personal"

call plug#begin('~/.config/nvim/plugged')

" native LSP for neovim
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'onsails/lspkind-nvim' 

" completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

" status bar
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" colorschemes
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'rose-pine/neovim'
Plug 'flazz/vim-colorschemes'

" fantastic fuzzy finder and dependencies
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" comment out stuff gcc
Plug 'tpope/vim-commentary'

" a ton of language syntax support loaded on-demand
Plug 'sheerun/vim-polyglot'

" git stuff
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" tree-sitter
Plug 'nvim-treesitter/nvim-treesitter'

"neoformat
Plug 'sbdchd/neoformat'

"harpoon
Plug 'nvim-lua/plenary.nvim'

call plug#end()

""""""""""""""""""""""
" source files
""""""""""""""""""""""

" source vim files
source ~/.config/nvim/plugins/base.vim
source ~/.config/nvim/plugins/tabline.vim
source ~/.config/nvim/plugins/neoformat.vim

" source lua files
lua require("jeffyang.nvim-cmp")
lua require("jeffyang.lsp-config")
lua require("jeffyang.lua-line")
lua require("jeffyang.git-signs")
lua require("jeffyang.colors")
lua require("jeffyang.telescope")
