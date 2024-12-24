# Also runs the loc_tables.lua script to compile the localization files
# into a single file for mods to use

# NOTE: This script is meant to be run from the root of the repository,
# so call it like this:
# ./scripts/pack_standalone.ps1

$DIST_DIR = "dist"
$OUTPUT_FILE = "THLocale-Standalone.zip"
$OUTPUT_DIR = "THLocale-Standalone"

$OUTPUT_DIR_PATH = Join-Path $DIST_DIR $OUTPUT_DIR
$OUTPUT_FILE_PATH = Join-Path $DIST_DIR $OUTPUT_FILE

function Cleanup {
    New-Item -ItemType Directory -Force -Path $DIST_DIR
    # clean up the output file
    Remove-Item -Force -Path $OUTPUT_FILE_PATH
    Remove-Item -Recurse -Force -Path "$OUTPUT_DIR_PATH/*"

    New-Item -ItemType Directory -Force -Path "$DIST_DIR/localization"
    Remove-Item -Recurse -Force -Path "$DIST_DIR/localization/*"

    # Remove l10n lints
    Remove-Item -Recurse -Force -Path "$DIST_DIR/missing_keys*"
}

function Zip-Dir {
    Push-Location $DIST_DIR
    Compress-Archive -Force -Path $OUTPUT_DIR -DestinationPath $OUTPUT_FILE
    Pop-Location
}

function Prepare {
    Copy-Item -Recurse -Force -Path "mods/ThaiLoc/*" -Destination $OUTPUT_DIR_PATH
    Copy-Item -Recurse -Force -Path "resources/textures" -Destination "$OUTPUT_DIR_PATH/assets"
    Copy-Item -Recurse -Force -Path "resources/fonts" -Destination "$OUTPUT_DIR_PATH/assets/fonts"
    & "lua54" (Join-Path $PSScriptRoot "loc_tables.lua")
    Copy-Item -Recurse -Force -Path "$DIST_DIR/localization" -Destination "$OUTPUT_DIR_PATH/localization"
    # Remove standalone-only files
    Remove-Item -Recurse -Force -Path "$OUTPUT_DIR_PATH/lovely/standalone.toml"
    # Remove localization extras
    Remove-Item -Recurse -Force -Path "$OUTPUT_DIR_PATH/localization/extras"
}

Cleanup

Prepare

Zip-Dir