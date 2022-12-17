" custom setting for prettier
let g:neoformat_try_node_exe = 1

let g:neoformat_enabled_javascript = ['prettier', 'eslint_d']
let g:neoformat_enabled_javascriptreact = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_typescriptreact = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_json = ['prettier']

let g:neoformat_enabled_python = ['autopep8']

let g:neoformat_enabled_lua = ['luafmt']

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
