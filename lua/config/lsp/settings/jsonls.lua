local schemastore_loaded, schemastore = pcall(require, "schemastore")

if not schemastore_loaded then
    print("schemastore not loaded")
    return
end

return { settings = { json = { schemas = schemastore.json.schemas(), validate = { enable = true } } } }
