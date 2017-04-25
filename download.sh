#!/usr/bin/env bash

regexETagHeader='ETag: "([^"]+)"'

while read source; do
	echo "Getting hosts from $source" > /dev/stderr

	headers=$(curl -sI "$source")

	ETag=""
	if [[ $headers =~ $regexETagHeader ]]; then
		ETag="${BASH_REMATCH[1]}"
	fi

	if [[ -f "./cache/${ETag}" ]]; then
		echo " - Using cache" > /dev/stderr
		sourceList=$(cat "./cache/${ETag}")
	else
		echo " - Downloading..." > /dev/stderr
		sourceList=$(curl -s "$source")
		echo "$sourceList" > "./cache/${ETag}"
	fi

	sourceCount=$(wc -l <<< "${sourceList}")

	echo " - Got $sourceCount hosts" > /dev/stderr

	echo "$sourceList"

done < sources.csv
