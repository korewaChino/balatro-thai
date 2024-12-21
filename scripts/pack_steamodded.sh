#!/bin/bash -x

# Pack the mod for Steamodded distribution
# Also runs the loc_tables.lua script to compile the localization files
# into a single file for mods to use

# NOTE: This script is meant to be run from the root of the repository,
# so call it like this:
# ./scripts/pack_steamodded.sh

DIST_DIR=dist
OUTPUT_FILE=THLocale-Steamodded.zip
OUTPUT_DIR=THLocale-Steamodded

OUTPUT_DIR_PATH=$DIST_DIR/$OUTPUT_DIR
OUTPUT_FILE_PATH=$DIST_DIR/$OUTPUT_FILE

function cleanup {
    mkdir -p dist
    # clean up the output file
    rm -f $OUTPUT_FILE_PATH
    rm -rf $OUTPUT_DIR_PATH/*

    mkdir -p $DIST_DIR/localization
    rm -rf $DIST_DIR/localization/*

    # Remove l10n lints
    rm -rf $DIST_DIR/missing_keys*
}

function zip_dir {
    pushd $DIST_DIR
    zip -r $OUTPUT_FILE $OUTPUT_DIR
    popd
}

function prepare {
    cp -av mods/ThaiLoc/. $OUTPUT_DIR_PATH
    cp -av resources/textures $OUTPUT_DIR_PATH/assets
    cp -av resources/fonts $OUTPUT_DIR_PATH/assets/fonts
    lua $(dirname $0)/loc_tables.lua
    cp -av $DIST_DIR/localization $OUTPUT_DIR_PATH/localization
    # Remove standalone-only files
    rm -rfv $OUTPUT_DIR_PATH/lovely/standalone.toml
    # Remove localization extras
    rm -rfv $OUTPUT_DIR_PATH/localization/extras
}

cleanup

prepare

zip_dir