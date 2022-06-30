local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
    return
end

-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`).
nvim_tree.setup({
    auto_reload_on_write = true,
    create_in_closed_folder = true,
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = false,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = false,
    open_on_setup_file = false,
    open_on_tab = false,
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    update_cwd = false,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    view = {
        adaptive_size = false,
        width = 30,
        height = 30,
        hide_root_folder = true,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
            custom_only = false,
            list = {},
        },
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        highlight_opened_files = "name", -- none, icon, name or all, Default: none
        root_folder_modifier = ":~",
        indent_markers = {
            enable = true,
            icons = {
                corner = "└ ",
                edge = "│ ",
                item = "│ ",
                none = "  ",
            },
        },
        icons = {
            webdev_colors = true,
            git_placement = "before", -- after, before or signcolumn, Default: before
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "M",
                    staged = "A",
                    unmerged = "U",
                    renamed = "R",
                    untracked = "?",
                    deleted = "D",
                    ignored = "◌",
                },
            },
        },
        special_files = {},
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = false,
        update_root = false,
        ignore_list = {},
    },
    ignore_ft_on_setup = {},
    system_open = {
        cmd = "",
        args = {},
    },
    diagnostics = {
        enable = false,
        show_on_dirs = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    filters = {
        dotfiles = false,
        custom = { "^\\.git$", "node_modules" },
        exclude = { ".gitignore" },
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 400,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        expand_all = {
            max_folder_discovery = 300,
        },
        open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = {
                        "notify",
                        "packer",
                        "qf",
                        "diff",
                        "fugitive",
                        "fugitiveblame",
                    },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
        remove_file = {
            close_window = true,
        },
    },
    trash = {
        cmd = "gio trash",
        require_confirm = true,
    },
    live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
    },
    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
        },
    },
})
