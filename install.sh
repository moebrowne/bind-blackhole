#!/usr/bin/env bash

# Get the source directory
SOURCE_ROOT="${BASH_SOURCE%/*}"

source "$SOURCE_ROOT/libs/configLocations.sh"

read -r -d '' blackholeZone <<'EOF'
$TTL	400;
@		IN		SOA		ns0.example.net. hostmaster.example.net. (
						2017042300	; serial number YYMMDDNN
						3h			; Refresh
						1h			; Retry
						1w			; Expire
						1h )		; Min TTL

@		IN		NS      ns0.example.net.
@		IN		NS      ns1.example.net.

*		IN		CNAME	analysis.example.net
EOF

if [[ ! -w "$configLocation" ]]; then
	echo "Can't write to the Bind config file! ($configLocation)"
	exit 2
fi

if [[ ! -w "$(dirname "$blackholeZoneLocation")" ]]; then
	echo "Can't write to the black hole zone file! ($blackholeZoneLocation)"
	exit 2
fi

echo "$blackholeZone" > "$blackholeZoneLocation"

echo "include \"${blackholeListLocation}\";" >> "$configLocation"

touch "${blackholeListLocation}"
