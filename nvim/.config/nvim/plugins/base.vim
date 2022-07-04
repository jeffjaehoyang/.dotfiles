" easy way to source init.vim file
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

"{ Global Variable
"{{ Custom variables
let g:is_win = (has('win32') || has('win64')) ? v:true : v:false
let g:is_linux = (has('unix') && !has('macunix')) ? v:true : v:false
let g:is_mac = has('macunix') ? v:true : v:false
let g:logging_level = 'info'
"}}
"
let mapleader = ","
nmap <leader>w :w<cr>

syntax on
filetype plugin indent on
syntax enable

set path+=**

" Ignore certain files and folders when globing
" Ignore files
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*
set wildignore+=*.o,*.obj,*.dylib,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.pyc,*.pkl
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
set wildignorecase  " ignore file and dir name cases in cmd-completion

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu

" Use mouse to select and resize windows, etc.
set mouse=nic  " Enable mouse in several mode
set mousemodel=popup  " Set the behaviour of mouse

set number relativenumber
set colorcolumn=80
set scrolloff=4
set cmdheight=1
set backspace=eol,start,indent
" set nowrap
set noswapfile
set nobackup
set nowb
set hidden
set incsearch
set lazyredraw
set showmatch
set mat=2

set visualbell noerrorbells  " Do not use visual and errorbells
set history=500  " The number of command and search history to keep

set t_vb=
set tm=500
set encoding=utf8
set ffs=unix,dos,mac
set expandtab
set smarttab

set ignorecase smartcase

set shiftwidth=2
set tabstop=2
" Linebreak on 500 characters
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent

" set splitbelow
set splitright
set updatetime=50
set shortmess+=c
set tabline=

set guicursor=i:block
set guicursor+=n-v-i-c:blinkon1

try
  colorscheme gruvbox
catch
endtry

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
set background=dark

try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" attempt to autoformat buffers
autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()

" netrw instead of nerdtree
map <leader>nn :Explore<cr>

" if you want to do stuff like setting background images
hi Normal ctermbg=NONE
hi SignColumn ctermbg=none ctermfg=none guifg=none guibg=none
hi LineNr ctermbg=none guibg=none

" Git Signs stuff
hi GitSignsAdd ctermbg=None ctermfg=green
hi GitSignsChange ctermbg=None ctermfg=blue
hi GitSignsDelete ctermbg=None ctermfg=red

hi LineNr ctermfg=074
hi WinSeparator guibg=NONE

" lsp diagnostics error text color
hi DiagnosticError guifg=Red ctermbg=None

" lsp diagnostics sign column bg color transparent
hi DiagnosticSignError ctermbg=None
hi DiagnosticSignWarn ctermbg=None
hi DiagnosticSignHint ctermbg=None
hi DiagnosticSignInfo ctermbg=None


if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" highlight in grey
hi Visual cterm=none ctermbg=242

" Smart way to move between windows
nnoremap <silent> <S-J> <C-W>j
nnoremap <silent> <S-K> <C-W>k
nnoremap <silent> <S-H> <C-W>h
nnoremap <silent> <S-L> <C-W>l

" Change 2 split windows from vert to horiz or horiz to vert
map <leader>tk <C-w>t<C-w>H
map <leader>th <C-w>t<C-w>K

" Make adjusing split sizes a bit more friendly
noremap <silent> <S-Left> :vertical resize +3<CR>
noremap <silent> <S-Right> :vertical resize -3<CR>
noremap <silent> <S-Up> :resize +3<CR>
noremap <silent> <S-Down> :resize -3<CR>

" Greatest buffer remaps evuhhh
nnoremap gb :ls<CR>:b<Space>
nnoremap <leader>vs :ls<cr>:vsp<space>\|<space>b<space>
nnoremap <leader>s :ls<cr>:sp<space>\|<space>b<space>
nnoremap <leader>bd :bd<cr>


" this stuff is magic lets you move lines around in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv 

" Remap VIM 0 to first non-blank character
map 0 ^

augroup loadFiletypeSettings 
  autocmd!
  autocmd Filetype vim        setlocal shiftwidth=2 tabstop=2
  autocmd Filetype javascript setlocal shiftwidth=2 tabstop=2
  autocmd Filetype javascriptreact setlocal shiftwidth=2 tabstop=2
  autocmd Filetype typescript setlocal shiftwidth=2 tabstop=2
  autocmd Filetype typescriptreact setlocal shiftwidth=2 tabstop=2
  autocmd Filetype html       setlocal shiftwidth=2 tabstop=2
  autocmd Filetype css       setlocal shiftwidth=2 tabstop=2
  autocmd Filetype python     setlocal shiftwidth=4 softtabstop=4 expandtab
  autocmd Filetype hack       setlocal shiftwidth=2 tabstop=2
  autocmd Filetype c          setlocal shiftwidth=4 tabstop=4
  autocmd Filetype cpp        setlocal shiftwidth=4 tabstop=4
augroup END

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

if has("mac") || has("macunix")
  nmap <D-k> <M-k>
  nmap <D-j> <M-j>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

if has("autocmd")
  autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

function! CmdLine(str)
  call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'gv'
    call CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" => Fast editing and reloading of vimrc configs
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

let g:python3_host_prog='/usr/local/bin/python3'
" Add the virtualenv's site-packages to vim path
if has('python')
  py << EOF
  import os.path
  import sys
  import vim
  if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif
