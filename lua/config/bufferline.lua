local bufferline_loaded, bufferline = pcall(require, "bufferline")

if bufferline_loaded == false then
    print("bufferline not loaded")
    return
end

bufferline.setup({
    options = {
        indicator_icon = " ",
        offsets = { { filetype = "NvimTree", text = "", padding = 0 } },
        separator_style = { "", "" },
        sort_by = "insert_at_end",
    },
    highlights = { buffer_selected = { gui = "none" } },
})
