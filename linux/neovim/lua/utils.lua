M = {}
local loaded = {}
function M.load_rust_analyzer()
    local filename = vim.fn.getcwd() .. "/.rust_analyzer.lua"
    if vim.fn.exists(filename) ~= 0 then
        if loaded[filename] == nil then
            i = vim.fn.input('load ' .. filename .. '? (y/n) ')
            if i == 'y' then
                fn = loadfile(filename)()
                loaded[filename] = fn
            end
        end
    end
    return loaded[filename]
end
return M
