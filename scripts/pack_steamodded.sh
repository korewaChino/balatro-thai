#!/bin/bash -x

# Pack the mod for Steamodded distribution
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

    cp -av mods/ThaiLoc/. $OUTPUT_DIR_PATH
}

function zip_dir {
    pushd $DIST_DIR
    zip -r $OUTPUT_FILE $OUTPUT_DIR
    popd
}


function prepare {
    cp -av resources $OUTPUT_DIR_PATH/assets
    cp -av localization $OUTPUT_DIR_PATH/localization
}

cleanup

prepare

zip_dir