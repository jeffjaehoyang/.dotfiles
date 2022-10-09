-- separate between work and personal machine

if vim.g.machine_env == "work" and vim.g.is_linux then
    vim.api.nvim_set_keymap("n", "<C-p>", [[<cmd>Telescope myles<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "<C-f>", [[<cmd>Telescope biggrep s<CR>]], {noremap = true, silent = true})
else
    vim.api.nvim_set_keymap("n", "<C-p>", [[<cmd>Telescope find_files<CR>]], {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "<C-f>", [[<cmd>Telescope live_grep<CR>]], {noremap = true, silent = true})
end

vim.api.nvim_set_keymap("n", "<leader>b", [[<cmd> Telescope buffers<CR>]], {noremap = true, silent = true})
