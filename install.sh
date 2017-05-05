#!/usr/bin/env bash

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

if [[ -d '/etc/named' ]]; then
	# RHEL/CentOS Style
	configLocation='/etc/named.conf'
	blackholeZoneLocation='/etc/named/blackhole'
	blackholeListLocation='/etc/named.blackhole.zones'
elif [[ -d '/etc/bind' ]]; then
	# Debian Style
	configLocation='/etc/bind/named.conf'
	blackholeZoneLocation='/etc/bind/db.blackhole'
	blackholeListLocation='/etc/bind/named.conf.blackhole'
else
	echo 'Unable to locate Bind config!'
	exit 1
fi

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
