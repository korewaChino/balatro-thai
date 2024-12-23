do
    --- Compares two tables recursively and returns a table of missing key-value pairs
    --- Only compares string keys and their corresponding values
    --- @param t1 table The first table to compare
    --- @param t2 table The second table to compare against
    --- @return table A table containing missing key-value pairs from t2 that exist in t1
    --- If the value is a table, recursively compares nested tables
    function table.compare(t1, t2)
        local function compare_recursive(a, b)
            local missing = {}
            for k, v in pairs(a) do
                if type(k) == "string" then
                    if b[k] == nil then
                        missing[k] = v
                    elseif type(v) == "table" then
                        local sub_missing = compare_recursive(v, b[k])
                        if next(sub_missing) then
                            missing[k] = sub_missing
                        end
                    end
                end
            end
            return missing
        end
        return compare_recursive(t1, t2)
    end

    --- Merge two tables together recursively
    --- @param into table - The target table that will be modified
    --- @param from table - The source table to merge from
    --- @return table - The modified target table
    function merge_tables(into, from)
        for k, v in pairs(from) do
            if type(v) == "table" and type(into[k]) == "table" then
                merge_tables(into[k], v)
            else
                into[k] = v
            end
        end
        return into
    end

    --- Lists all files in a specified directory
    --- @param directory string Directory path to list files from
    --- @return table<string, string> Table where keys are filenames and values are full paths
    --- Example:
    --- ```lua
    --- local files = list_files("/path/to/dir")
    --- - Returns: { ["file.txt"] = "/path/to/dir/file.txt", ... }
    --- ```
    function list_files(directory)
        local i, t, popen = 0, {}, io.popen
        for filename in popen('ls -a "' .. directory .. '"'):lines() do
            i = i + 1
            t[filename] = directory .. "/" .. filename
        end
        return t
    end

    --- Loads and returns a table from a Lua script file.
    --- The script file must return a table when executed.
    ---
    --- @param script string Path to the Lua script file
    --- @return table|nil Returns the loaded table if successful, nil if the file couldn't be loaded
    function table.load(script)
        local f = loadfile(script)
        if f then
            return f()
        end
        return nil
    end

    --- Exports a Lua table to a string representation.
    --- This function converts a table into a formatted string that represents the table structure,
    --- making it suitable for serialization or debugging purposes.
    ---
    --- @param tbl table The table to be exported
    --- @param indent string|nil Optional indentation string for formatting (default: "")
    --- @return string A string representation of the table with proper formatting and indentation
    function table.export(tbl, indent)
        local indent = indent or ""
        local result = "{\n"

        for k, v in pairs(tbl) do
            local key = type(k) == "string" and string.format('["%s"]', k) or string.format("[%s]", k)
            local value

            if type(v) == "table" then
                value = table.export(v, indent .. "    ")
            elseif type(v) == "string" then
                value = string.format("%q", v)
            else
                value = tostring(v)
            end

            result = result .. string.format('%s    %s = %s,\n', indent, key, value)
        end

        return result .. indent .. "}"
    end

    --- Converts a Lua table to a string representation.
    --- The returned string can be used with `loadstring()` to recreate the original table.
    --- @param tbl table The table to convert to a string
    --- @return string A string that can be executed to recreate the table
    function table.to_string(tbl)
        return "return " .. table.export(tbl)
    end

    --- Saves a Lua table to a file
    --- @param tbl table The table to save
    --- @param filename string The path to the file where the table will be saved
    --- @return nil
    function table.save(tbl, filename)
        local file = io.open(filename, "w")
        file:write(table.to_string(tbl))
        file:close()
    end
end
