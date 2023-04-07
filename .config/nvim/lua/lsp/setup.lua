-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local opts = { noremap = true, silent = true}
vim.api.nvim_set_keymap("n", "]d",
                        "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded', width = 50 })<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[d",
                        "<cmd>lua vim.diagnostic.goto_next({ popup_opts = { border = 'rounded', width = 50 }})<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<space>e",
                        "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', width = 50 })<CR>",
                        {noremap = true, silent = true})
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- vim.diagnostic.config({
--     virtual_lines = { only_current_line = true }
-- })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({width = 120}) end, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help({width = 80}) end, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<F2>', require('renamer').rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
end
local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- language servers
local servers = {"taplo", "pyright", "tsserver", "cssls", "html", "clangd", "bashls", "asm_lsp"}
local single = {"clangd", "bashls", "asm_lsp"}

require('lspconfig')['html'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    filetypes = { "html", "html.tera" }
}

require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' }
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = "Replace"
            }
        }
    },
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

for _, lsp in ipairs(servers) do
    if table.contains(single, lsp) then
        require('lspconfig')[lsp].setup {
            on_attach = on_attach,
            flags = lsp_flags,
            capabilities = capabilities,
        }
    else
        require('lspconfig')[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = lsp_flags,
            single_file_support = true,
        }
    end
end

require('lspconfig')["asm_lsp"].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    single_file_support = true,
}

-- emmet
if not configs.emmet_ls then
    configs.ls_emmet = {
        default_config = {
            cmd = { 'ls_emmet', '--stdio' };
            filetypes = {
                'html',
                'css',
                'scss',
                'javascriptreact',
                'typescriptreact',
                'haml',
                'xml',
                'xsl',
                'pug',
                'slim',
                'sass',
                'stylus',
                'less',
                'sss',
                'hbs',
                'handlebars',
                "html.tera"
            };
            root_dir = function(fname)
                return vim.loop.cwd()
            end;
            settings = {};
        };
    }
end

lspconfig.emmet_ls.setup { capabilities = capabilities }

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "rounded"
  }
)

local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = function(client, bufnr)
            -- Hover actions
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })

            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap = true, silent = true, buffer = bufnr}
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help({width = 80}) end, bufopts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<F2>', require('renamer').rename, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
        end,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }
            }
        }
    },
    tools = {
        hover_actions = {
            auto_focus = true
        },
        inlay_hints = {
            auto = false
        }
    }
})
