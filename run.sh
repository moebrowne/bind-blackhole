#!/usr/bin/env bash

# Get the source directory
SOURCE_ROOT="${BASH_SOURCE%/*}"

source "$SOURCE_ROOT/libs/configLocations.sh"

$SOURCE_ROOT/libs/download.sh | $SOURCE_ROOT/libs/parse.sh | sort | uniq  # > "${blackholeListLocation}"
