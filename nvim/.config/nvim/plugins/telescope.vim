" config for Telescope plugin (fuzzy finder)
" https://github.com/nvim-telescope/telescope.nvim

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope git_files<cr>
nnoremap <leader>f :lua require('telescope.builtin').current_buffer_fuzzy_find { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>af :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <C-f> <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
