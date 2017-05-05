#!/usr/bin/env bash

# Get the source directory
SOURCE_ROOT="${BASH_SOURCE%/*}"

DIR_CACHE="$SOURCE_ROOT/../cache"

if [ ! -d "$DIR_CACHE" ]; then
    mkdir "$DIR_CACHE" || exit 1
fi

regexETagHeader='ETag: "([^"]+)"'

while read source; do
	echo "Getting hosts from $source" > /dev/stderr

	headers=$(curl -sI "$source")

	ETag=""
	if [[ $headers =~ $regexETagHeader ]]; then
		ETag="${BASH_REMATCH[1]}"
	fi

	if [[ -f "$DIR_CACHE/${ETag}" ]]; then
		echo " - Using cache" > /dev/stderr
		sourceList=$(cat "$DIR_CACHE/${ETag}")
	else
		echo " - Downloading..." > /dev/stderr
		sourceList=$(curl -s "$source")
		echo "$sourceList" > "$DIR_CACHE/${ETag}"
	fi

	sourceCount=$(wc -l <<< "${sourceList}")

	echo " - Got $sourceCount hosts" > /dev/stderr

	echo "$sourceList"

done < sources.csv
