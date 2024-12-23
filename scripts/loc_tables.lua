dofile("scripts/lib/serialization.lua")

---@diagnostic disable: need-check-nil
-- This script is a tool that builds the final Thai language pack
-- for Thai Balatro: Soberized Edition by merging language tables into one big table.
-- from steamodded and the base game.
-- The script will output a file to dist/localization/th_TH.lua.
-- This is the final language pack that will be used in the mod.



local extra_scripts = list_files("localization/extras")
local extra_scripts_og = list_files("original_text")

local scripts = {
    localized = "localization/th_TH.lua",
    -- original_text = {
    --     basegame = "original_text/en-us.lua",
    --     steamodded = "original_text/en-us-stm.lua",
    -- },
    -- localized_extras = {
    --     steamodded = "localization/extras/steamodded.lua",
    -- }
}

-- Output file location
local output_file = "dist/localization/th_TH.lua"

-- Load all scripts, extensible for future use
local function load_scripts()
    local final_script = table.load(scripts.localized)

    print(table.to_string(extra_scripts))

    print("Loaded main script")
    for k, script_path in pairs(extra_scripts) do
        -- print("Loading extra script `" .. k .. "`: " .. script_path)
        if k ~= "." and k ~= ".." then
            local key = k:match("(.+).lua")
            print("Loading extra script `" .. key .. "`: " .. script_path)
            local table = table.load(script_path)
            if table ~= nil then
                final_script = merge_tables(final_script, table)
            end
        end
    end

    -- Linter
    for k, script_path in pairs(extra_scripts_og) do
        if k ~= "." and k ~= ".." then
            local key = k:match("(.+).lua")
            print("Linting extra script `" .. key .. "`: " .. script_path)

            local script = table.load(script_path)
            if table ~= nil then
                local lint = table.compare(script, final_script)
                if next(lint) then
                    table.save(lint, "dist/missing_keys_" .. key .. ".lua")
                    print("Missing keys from " .. key .. " dumped to dist/missing_keys_" .. key .. ".lua")
                end
            end
        end
    end

    return final_script
end


-- Export to table to a script

print("Merging Localization tables...")

local final_output = load_scripts()

table.save(final_output, output_file)

-- print(table_to_string(final_output))


-- local missing_keys = compare_tables(en_script, th_script)

-- print(table_to_string(missing_keys))
