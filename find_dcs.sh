#!/bin/bash
# Ask for file name/location
# Ask for input to start enum4linux
# Ask for enum4linux file name/location
read -e -p 'Domain Controller file name/location? [/root/domain_controllers]: ' dc_name
read -e -p 'Run enum4linux? [Y/n]: ' dc_enum_choice

dc_enum_choice=${dc_enum_choice:-y}
dc_name=${dc_name:-/root/domain_controllers}

echo "Finding Domain Controllers..."
nmsrv=$(cat /etc/resolv.conf | grep search | awk '{print $2}')
dig +short any _kerberos._tcp.$nmsrv | awk '{print $4}' | sed 's/\.$//g' > $dc_name
echo "List of Domain Controllers output to $dc_name"

if dc_enum_choice==y; then
	read -e -p 'File Location for enum4linux results? [/root]: ' enum_loc
	echo "Running Enum4Linux against identified Domain Controllers. This might take a while"
	for x in $dc_name; do enum4linux -a $x > $enum_loc/dc_enum_$x; done
else
	exit
