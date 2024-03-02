local M = {
    'neovim/nvim-lspconfig',
    cmd = { 'LspStart' },
    dependencies = {
        require 'gmr.plugins.null-ls',
        require 'gmr.plugins.navic',
        require 'gmr.plugins.trouble',
        require 'gmr.plugins.noice',
        { 'b0o/SchemaStore.nvim' },
    },
}

--- @param client lsp.Client
--- @param bufnr integer
function M.on_attach(client, bufnr)
    local methods = vim.lsp.protocol.Methods

    vim.api.nvim_set_option_value(
        'omnifunc',
        'v:lua.vim.lsp.omnifunc',
        { buf = bufnr }
    )

    --- @param lhs string
    --- @param rhs string|function
    local function keymap(lhs, rhs)
        vim.keymap.set(
            'n',
            lhs,
            rhs,
            { noremap = true, silent = true, buffer = bufnr }
        )
    end

    keymap('<space>e', vim.diagnostic.open_float)
    keymap('[d', vim.diagnostic.goto_prev)
    keymap(']d', vim.diagnostic.goto_next)
    keymap('<space>q', vim.diagnostic.setloclist)
    keymap('gd', vim.lsp.buf.definition)
    keymap('J', vim.lsp.buf.hover)
    keymap('gi', function()
        require('fzf-lua').lsp_implementations()
    end)
    keymap('K', vim.lsp.buf.signature_help)
    keymap('<space>wa', vim.lsp.buf.add_workspace_folder)
    keymap('<space>wr', vim.lsp.buf.remove_workspace_folder)
    keymap('<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
    keymap('<space>D', vim.lsp.buf.type_definition)
    keymap('<space>rn', vim.lsp.buf.rename)
    keymap('<space>ca', function()
        require('fzf-lua').lsp_code_actions()
    end)
    keymap('gr', function()
        require('fzf-lua').lsp_references()
    end)
    keymap('<space>fo', function()
        vim.lsp.buf.format { async = true }
    end)
    keymap('<leader>ds', function()
        require('fzf-lua').lsp_document_symbols()
    end)
    keymap('<leader>ws', function()
        require('fzf-lua').lsp_live_workspace_symbols()
    end)

    if client.supports_method(methods.textDocument_declaration) then
        keymap('gD', vim.lsp.buf.declaration)
    end

    if client.supports_method(methods.textDocument_documentHighlight) then
        local augroup = vim.api.nvim_create_augroup(
            'gmr_lsp_document_highlight',
            { clear = false }
        )

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = augroup,
            desc = 'Highlight references under the cursor',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = augroup,
            desc = 'Clear highlight references after move cursor',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    if client.supports_method(methods.textDocument_inlayHint) then
        vim.lsp.inlay_hint.enable(bufnr, false)

        keymap('<leader>ih', function()
            vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
        end)
    end

    -- if client.name == 'jdtls' then
    --     -- jdtls dap
    --     -- require("jdtls").setup_dap({ hotcodereplace = "auto" })
    --     -- require("jdtls.dap").setup_dap_main_class_configs()

    --     -- jdtls commands
    --     -- require("jdtls.setup").add_commands()
    --     -- vim.api.nvim_create_gmr_command("JdtTestClass", function()
    --     --   require("jdtls").test_class()
    --     -- end, {})
    --     -- vim.api.nvim_create_gmr_command("JdtTestNearestMethod", function()
    --     --   require("jdtls").test_nearest_method()
    --     -- end, {})
    -- end

    require('gmr.plugins.navic').attach(client, bufnr)
end

function M.diagnostic_config()
    local diagnostics_icons = {
        ERROR = '',
        WARN = '',
        HINT = '',
        INFO = '',
    }

    vim.diagnostic.config {
        underline = true,
        virtual_text = {
            source = false,
            spacing = 1,
            prefix = '',
            suffix = '',
            format = function(diagnostic)
                local severity = vim.diagnostic.severity[diagnostic.severity]
                local icon = diagnostics_icons[severity]
                return string.format(
                    '%s %s: %s ',
                    icon,
                    diagnostic.source,
                    diagnostic.message
                )
            end,
        },
        signs = false,
        float = { source = 'always', border = 'single' },
        update_in_insert = false,
        severity_sort = true,
    }
end

function M.handlers()
    local methods = vim.lsp.protocol.Methods
    local handlers = require 'gmr.configs.lsp.handlers'

    vim.lsp.handlers[methods.textDocument_definition] =
        handlers.goto_definition()

    -- comment this if using noice.nvim
    -- vim.lsp.handlers[methods.textDocument_hover] =
    --     vim.lsp.with(vim.lsp.handlers.hover, { border = chars.border })

    vim.lsp.handlers[methods.textDocument_signatureHelp] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
end

function M.config()
    local lspconfig = require 'lspconfig'

    M.diagnostic_config()
    M.handlers()

    require('lspconfig.ui.windows').default_options.border = 'single'

    local configs = require 'lspconfig.configs'

    configs['pylance'] = require 'gmr.configs.lsp.settings.pylance'

    local servers = require('gmr.configs.lsp.servers').to_setup

    for _, server in pairs(servers) do
        local server_opts = {
            on_attach = M.on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }

        local has_custom_opts, server_custom_opts =
            pcall(require, 'gmr.configs.lsp.settings.' .. server)
        if has_custom_opts then
            server_opts =
                vim.tbl_deep_extend('force', server_opts, server_custom_opts)
        end

        local has_custom_commands, server_custom_commands =
            pcall(require, 'gmr.configs.lsp.commands.' .. server)
        if has_custom_commands then
            server_opts.commands = server_custom_commands
        end

        if server == 'lua_ls' then
            require('neodev').setup {}
        end

        lspconfig[server].setup(server_opts)
    end
end

return M