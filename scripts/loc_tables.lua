---@diagnostic disable: need-check-nil
-- This script is a helper tool that builds the final Thai language pack
-- for Thai Balatro: Soberized Edition by merging the 2 language tables
-- from steamodded and the base game

--

-- Compare two tables and return missing keys recursively


-- Compares two tables and returns a table of missing keys
-- Will compare T2 to T1, and return a table of keys that are in T1 but not in T2
local function compare_tables(t1, t2)
    local missing_keys = {}
    for k, v in pairs(t1) do
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
    return missing_keys
end
--- Merge two tables together recursively

local function merge_tables(into,from)
	local stack = {}
	local node1 = into
	local node2 = from
	while (true) do
		for k,v in pairs(node2) do
			if (type(v) == "table" and type(node1[k]) == "table") then
				table.insert(stack,{node1[k],node2[k]})
			else
				node1[k] = v
			end
		end
		if (#stack > 0) then
			local t = stack[#stack]
			node1,node2 = t[1],t[2]
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


-- Tables to load
local th_script = load_table("localization/th_TH.lua")
local th_script_stm = load_table("localization/th_TH-stm.lua")


-- Original English scripts
local en_script = load_table("original_text/en-us.lua")
local en_script_stm = load_table("original_text/en-us-stm.lua")


-- Output file location
local output_file = "dist/localization/th_TH.lua"


-- Export to table to a script
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


print("Merging Localization tables...")

local final_output = merge_tables(th_script_stm, th_script)

local lint = compare_tables(en_script_stm, final_output)
warn("Missing keys from steamodded: " .. table_to_string(lint))


write_to_file(final_output, output_file)

-- print(table_to_string(final_output))


-- local missing_keys = compare_tables(en_script, th_script)

-- print(table_to_string(missing_keys))
