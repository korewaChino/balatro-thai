---@diagnostic disable: need-check-nil
-- This script is a tool that builds the final Thai language pack
-- for Thai Balatro: Soberized Edition by merging language tables into one big table.
-- from steamodded and the base game.
-- The script will output a file to dist/localization/th_TH.lua.
-- This is the final language pack that will be used in the mod.


-- Compares two tables and returns a table of missing keys
-- Will compare T2 to T1, and return a table of keys that are in T1 but not in T2
-- Ignores numeric keys because arrays are usually flexible line-delimited strings
local function compare_tables(t1, t2)
    local missing_keys = {}
    for k, v in pairs(t1) do
        -- Only process non-numeric keys
        if type(k) == "string" then
            if type(v) == "table" then
                if t2[k] == nil then
                    -- If key doesn't exist in t2, copy entire subtable
                    missing_keys[k] = v
                else
                    -- Recursively compare subtables
                    local sub_missing = compare_tables(v, t2[k])
                    if next(sub_missing) then -- Only add if there are missing keys
                        missing_keys[k] = sub_missing
                    end
                end
            else
                if t2[k] == nil then
                    -- If key doesn't exist in t2, copy value
                    missing_keys[k] = v
                end
            end
        end
    end
    return missing_keys
end

--- Merge two tables together recursively
local function merge_tables(into, from)
    local stack = {}
    local node1 = into
    local node2 = from
    while (true) do
        for k, v in pairs(node2) do
            if (type(v) == "table" and type(node1[k]) == "table") then
                table.insert(stack, { node1[k], node2[k] })
            else
                node1[k] = v
            end
        end
        if (#stack > 0) then
            local t = stack[#stack]
            node1, node2 = t[1], t[2]
            stack[#stack] = nil
        else
            break
        end
    end
    return into
end
-- load table from lua scripts
-- the l10n strings are literally stored as a lua script that returns a table


local function load_table(script)
    local f = loadfile(script)
    if f then
        return f()
    end
    return nil
end

local function export_table(tbl, indent)
    indent = indent or ""
    local result = "{\n"
    for k, v in pairs(tbl) do
        if type(k) == "string" then
            result = result .. indent .. "    [\"" .. k .. "\"] = "
        else
            result = result .. indent .. "    [" .. tostring(k) .. "] = "
        end

        if type(v) == "table" then
            result = result .. export_table(v, indent .. "    ")
        elseif type(v) == "string" then
            result = result .. string.format("%q", v)
        else
            result = result .. tostring(v)
        end
        result = result .. ",\n"
    end
    return result .. indent .. "}"
end

local function table_to_string(tbl)
    return "return " .. export_table(tbl)
end


local function write_to_file(tbl, filename)
    local file = io.open(filename, "w")
    file:write(table_to_string(tbl))
    file:close()
end

-- Tables to load
local th_script = load_table("localization/th_TH.lua")
local th_script_stm = load_table("localization/th_TH-stm.lua")


-- Original English scripts
local en_script = load_table("original_text/en-us.lua")
local en_script_stm = load_table("original_text/en-us-stm.lua")

local scripts = {
    localized = "localization/th_TH.lua",
    original_text = {
        basegame = "original_text/en-us.lua",
        steamodded = "original_text/en-us-stm.lua",
    },
    localized_extras = {
        steamodded = "localization/extras/steamodded.lua",
    }
}

-- Output file location
local output_file = "dist/localization/th_TH.lua"

-- Load all scripts, extensible for future use
local function load_scripts()
    local final_script = load_table(scripts.localized)

    print("Loaded main script")
    for k, script_path in pairs(scripts.localized_extras) do
        print("Loading extra script `" .. k .. "`: " .. script_path)
        final_script = merge_tables(final_script, load_table(script_path))
    end

    -- Linter
    for k, script_path in pairs(scripts.original_text) do
        local script = load_table(script_path)
        local lint = compare_tables(script, final_script)
        if next(lint) then
            write_to_file(lint, "dist/missing_keys_" .. k .. ".lua")
            print("Missing keys from " .. k .. " dumped to dist/missing_keys_" .. k .. ".lua")
        end
    end

    return final_script
end


-- Export to table to a script

print("Merging Localization tables...")

local final_output = load_scripts()

write_to_file(final_output, output_file)

-- print(table_to_string(final_output))


-- local missing_keys = compare_tables(en_script, th_script)

-- print(table_to_string(missing_keys))