local kommentary_config_loaded, kommentary_config = pcall(require, "kommentary.config")

if not kommentary_config_loaded then
    print("kommentary.config not loaded")
    return
end

kommentary_config.configure_language("default", { prefer_single_line_comments = true })

kommentary_config.use_extended_mappings()
