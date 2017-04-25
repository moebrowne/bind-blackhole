#!/usr/bin/env bash

newline=$'\x0D'
lineFeed=$'\x0A'

regexHostType="^[0-9\.]{7,15}[[:space:]]+([^"${newline}${lineFeed}" #]+)" # To match: 0.0.0.0 somedomain.com
regexDomainType="^([^ #]+)" # To match: somedomain.com

while read line; do
	FQDN=""

	if [[ $line =~ $regexHostType ]]; then
		FQDN="${BASH_REMATCH[1]}"
	elif [[ $line =~ $regexDomainType ]]; then
		FQDN="${BASH_REMATCH[1]}"
	fi

	if [[ "$FQDN" = "localhost" ]]; then
		continue;
	fi

	if [[ "$FQDN" != "" ]]; then
		echo "zone \"$FQDN\" { type master;  file \"/etc/named/blackhole\"; };"
	fi

done < /dev/stdin
