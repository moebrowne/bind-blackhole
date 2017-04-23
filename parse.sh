#!/usr/bin/env bash

regexLine="[^ ]+[[:space:]]+(.+)"

while read line; do

	[[ $line =~ $regexLine ]]

	if [[ ${BASH_REMATCH[0]} != "" ]]; then
		echo "zone \"${BASH_REMATCH[1]}\" { type master;  file \"/etc/named/blackhole\"; };"
	fi

done < /dev/stdin
