#!/usr/bin/env bash

while read source; do
	echo "Downloading from $source" > /dev/stderr
	sourceList=$(curl -s "$source")
	sourceCount=$(wc -l <<< "${sourceList}")

	echo " Found $sourceCount hosts" > /dev/stderr

	echo "$sourceList"

done < sources.csv
