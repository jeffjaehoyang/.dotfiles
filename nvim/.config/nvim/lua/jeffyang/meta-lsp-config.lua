require("meta.lsp")
local servers = { "rusty@meta", "pyls@meta", "pyre@meta", "thriftlsp@meta", "cppls@meta", "eslint@meta", "prettier@meta" }
local lsp_config = require("lspconfig") 
local lsp_util = require("jeffyang.lsp-config")

for _, lsp in ipairs(servers) do
  lsp_config[lsp].setup {
    on_attach = on_attach,
  }
end
	
-- Start a language server client from a native lspconfig config.
lsp_config["flow"].setup({
  cmd = { "flow", "lsp" },
  on_attach = lsp_util.on_attach,
  capabilities = lsp_util.capabilities,
})

lsp_config["hhvm"].setup({
  on_attach = lsp_util.on_attach,
  capabilities = lsp_util.capabilities,
})
