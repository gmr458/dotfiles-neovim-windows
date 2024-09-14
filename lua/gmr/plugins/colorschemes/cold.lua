return {
    'gmr458/cold.nvim',
    lazy = false,
    priority = 1000,
    build = ':ColdCompile',
    config = function()
        require('cold').setup {
            transparent_background = true,
            cursorline = false,
        }
        vim.cmd.colorscheme 'cold'
    end,
}
