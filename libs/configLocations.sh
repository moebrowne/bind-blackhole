
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