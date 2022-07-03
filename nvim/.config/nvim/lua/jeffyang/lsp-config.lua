-- from https://github.com/jdhao/nvim-config
--
local api = vim.api
local lsp = vim.lsp

local utils = require("jeffyang.utils")

local M = {}

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

local custom_attach = function(client, bufnr)
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

    -- Set some key bindings conditional on server capabilities
    -- if client.resolved_capabilities.document_formatting then
    --     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
    -- end
    -- if client.resolved_capabilities.document_range_formatting then
    --     buf_set_keymap("x", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR><ESC>", opts)
    -- end

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

local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

if utils.executable("pylsp") then
    lspconfig.pylsp.setup({
        on_attach = custom_attach,
        settings = {
            pylsp = {
                plugins = {
                    pylint = {enabled = true, executable = "pylint"},
                    pyflakes = {enabled = false},
                    pycodestyle = {enabled = false},
                    jedi_completion = {fuzzy = true},
                    pyls_isort = {enabled = true},
                    pylsp_mypy = {enabled = true}
                }
            }
        },
        flags = {debounce_text_changes = 200},
        capabilities = capabilities
    })
else
    vim.notify("pylsp not found!", "warn", {title = "Nvim-config"})
end

if utils.executable("ccls") then
    lspconfig.ccls.setup({
        on_attach = custom_attach,
        capabilities = capabilities,
        filetypes = {"c", "cpp", "cc"},
        flags = {debounce_text_changes = 500}
    })
else
    vim.notify("ccls not found!", "warn", {title = "Nvim-config"})
end

if utils.executable("tsserver") then
    lspconfig.tsserver.setup({
        on_attach = custom_attach,
        capabilities = capabilities
    })
end

-- https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887
lspconfig.diagnosticls.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "json", "typescript",
        "typescriptreact", "typescript.tsx", "css", "less", "scss", "markdown",
        "pandoc"
    },
    init_options = {
        linters = {
            eslint = {
                command = "eslint_d",
                rootPatterns = {".git"},
                debounce = 100,
                args = {
                    "--stdin", "--stdin-filename", "%filepath", "--format",
                    "json"
                },
                sourceName = "eslint_d",
                parseJson = {
                    errorsRoot = "[0].messages",
                    line = "line",
                    column = "column",
                    endLine = "endLine",
                    endColumn = "endColumn",
                    message = "[eslint] ${message} [${ruleId}]",
                    security = "severity"
                },
                securities = {[2] = "error", [1] = "warning"}
            }
        },
        filetypes = {
            javascript = "eslint",
            javascriptreact = "eslint",
            ["javascript.jsx"] = "eslint",
            typescript = "eslint",
            typescriptreact = "eslint",
            ["typescript.tsx"] = "eslint"
        }
    }
}

-- set up vim-language-server
if utils.executable("vim-language-server") then
    lspconfig.vimls.setup({
        on_attach = custom_attach,
        flags = {debounce_text_changes = 500},
        capabilities = capabilities
    })
else
    vim.notify("vim-language-server not found!", "warn", {title = "Nvim-config"})
end

-- local sumneko_binary_path = vim.fn.exepath("lua-language-server")
local sumneko_root_path = "/Users/jeffyang/.config/nvim/lua-language-server"
if vim.g.is_mac or vim.g.is_linux and sumneko_root_path ~= "" then
    local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
    -- local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ":h:h:h")

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    lspconfig.sumneko_lua.setup({
        on_attach = custom_attach,
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    -- Setup your lua path
                    path = runtime_path
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {"vim"}
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = api.nvim_get_runtime_file("", true)
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {enable = false}
            }
        },
        capabilities = capabilities
    })
end

local signs = {
    {name = "DiagnosticSignError", text = "Ε"},
    {name = "DiagnosticSignWarn", text = "!"},
    {name = "DiagnosticSignHint", text = ""},
    {name = "DiagnosticSignInfo", text = ""}
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

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})

return M
