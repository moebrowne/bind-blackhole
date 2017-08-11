#!/usr/bin/env bash

# Get the source directory
SOURCE_ROOT="${BASH_SOURCE%/*}"

DIR_CACHE="$SOURCE_ROOT/../cache"

if [ ! -d "$DIR_CACHE" ]; then
    mkdir "$DIR_CACHE" || exit 1
fi

regexETagHeader='ETag: "([^"]+)"'
regexCodeHeader='HTTP/[1-2]\.[1-2] ([0-9]+) ([a-zA-Z0-9 ]+)'

while read source; do
	echo "Getting hosts from $source" > /dev/stderr

	headers=$(curl -sI "$source")

	# Check that we got a 200 response
	[[ $headers =~ $regexCodeHeader ]]
	if [[ "${BASH_REMATCH[1]}" != "200" ]]; then
	    echo " - Error: ${BASH_REMATCH[2]}"
	    continue
	fi

	ETag=""
	if [[ $headers =~ $regexETagHeader ]]; then
		ETag="${BASH_REMATCH[1]}"
	fi

	if [[ "${ETag}" != "" && -f "$DIR_CACHE/${ETag}" ]]; then
		echo " - Using cache" > /dev/stderr
		sourceList=$(cat "$DIR_CACHE/${ETag}")
	else
		echo " - Downloading..." > /dev/stderr
		sourceList=$(curl -s "$source")

		if [[ "${ETag}" != "" ]]; then
            echo "$sourceList" > "$DIR_CACHE/${ETag}"
		fi
	fi

	sourceCount=$(wc -l <<< "${sourceList}")

	echo " - Got $sourceCount hosts" > /dev/stderr

	echo "$sourceList"

done < "${SOURCE_ROOT}/../sources.csv"
