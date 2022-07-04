" (N)Vim Configuration File
" vim  : place in $HOME/.vimrc
" nvim : place in $HOME/.config/dotfiles/nvim/init.vim
" $ ln -s $HOME/.config/dotfiles/nvim/init.vim $HOME/.vimrc
" $ ln -s $HOME/.config/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim
" $ ln -s $HOME/.config/dotfiles/nvim/lua $HOME/.config/nvim/lua

call plug#begin('~/.config/nvim/plugged')

" native LSP for neovim
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'onsails/lspkind-nvim' 
Plug 'jose-elias-alvarez/null-ls.nvim'

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
Plug 'flazz/vim-colorschemes'

" fantastic fuzzy finder and dependencies
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

" comment out stuff gcc
Plug 'tpope/vim-commentary'

" nerdtree yes
" Plug 'preservim/nerdtree'

" auto pairing for brackets
" Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-autopairs'

" a ton of language syntax support loaded on-demand
Plug 'sheerun/vim-polyglot'

" git stuff
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" tree-sitter
Plug 'nvim-treesitter/nvim-treesitter'

" meta
Plug '/usr/share/fb-editor-support/nvim'

call plug#end()

""""""""""""""""""""""
" source files
""""""""""""""""""""""

" source vim files
source ~/.config/nvim/plugins/base.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/telescope.vim
source ~/.config/nvim/plugins/tabline.vim

" meta specific
lua require("meta")
lua require("meta.cmds")

" source lua files
lua require("jeffyang.null-ls")
lua require("jeffyang.meta-lsp-config")
lua require("jeffyang.telescope-config")
lua require("jeffyang.nvim-cmp")
lua require("jeffyang.lua-line")
lua require("jeffyang.git-signs")
lua require("jeffyang.nvim-autopairs")
