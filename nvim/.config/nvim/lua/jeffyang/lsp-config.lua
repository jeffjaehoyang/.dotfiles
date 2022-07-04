-- inspired from  https://github.com/jdhao/nvim-config
local lspconfig = require("lspconfig")
local utils = require("jeffyang.utils")
local api = vim.api
local lsp = vim.lsp
local M = {}
local capabilities = lsp.protocol.make_client_capabilities()

function M.show_line_diagnostics()
    local opts = {
        focusable = false,
        close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
        border = "rounded",
        source = "always", -- show source in diagnostic popup window
        prefix = " "
    }
    vim.diagnostic.open_float(nil, opts)
end

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "<C-]>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                   opts)
    buf_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>q",
                   "<cmd>lua vim.diagnostic.setqflist({open = true})<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",
                   opts)

    -- The blow command will highlight the current variable and its usages in the buffer.
    if client.resolved_capabilities.document_highlight then
        vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
    end

    if vim.g.logging_level == "debug" then
        local msg = string.format("Language server %s started!", client.name)
        vim.notify(msg, "info", {title = "Nvim-config"})
    end
end

M.on_attach = on_attach

capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = capabilities

local signs = {
    {name = "DiagnosticSignError", text = "Ε"},
    {name = "DiagnosticSignWarn", text = "W"},
    {name = "DiagnosticSignHint", text = "H"},
    {name = "DiagnosticSignInfo", text = "I"}
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name,
                       {texthl = sign.name, text = sign.text, numhl = ""})
end

local diagnostics_config = {
    virtual_text = {spacing = 2, prefix = "◼ "},
    -- show signs
    signs = {active = signs},
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focus = false,
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
    }
}

vim.diagnostic.config(diagnostics_config)

return M
