" custom setting for prettier
let g:neoformat_try_node_exe = 1

let g:neoformat_enabled_javascript = ['prettier', 'eslint_d']
let g:neoformat_enabled_javascriptreact = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_typescriptreact = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_css = ['prettier']

let g:neoformat_enabled_python = ['black']

let g:neoformat_enabled_lua = ['luafmt']

" custom setting for clangformat
let g:neoformat_c_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4, UseTab: Never, BreakBeforeBraces: Allman, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: false, ColumnLimit: 120}"'],
\}

let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4, UseTab: Never, BreakBeforeBraces: Allman, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: false, ColumnLimit: 120}"'],
\}

let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

augroup fmt
  autocmd!
  autocmd BufWritePre *.py,*.lua,*.cpp,*.c,*.h,*.js,*.jsx,*.ts,*.tsx,*.css,*.html undojoin | Neoformat
augroup END
