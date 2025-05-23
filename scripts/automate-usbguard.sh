#!/usr/bin/env bash

# read all IDs from detected USB devices into array using lsusb
id=$( lsusb | grep -oP '(?<=ID )[^ ]*')
id=($id)

# read all names into array
name=$( lsusb | sed 's/.*://' | cut -c6-)
readarray -t name <<<"$name"

# detect any blocked devices using usbguard list-devices
blocked=$( usbguard list-devices | grep -o -P '.{0,4}block' | grep -o '^[^:]*')
blocked=($blocked)

# if "-tmp" flag is set this function will temporarily add the blocked device
add_temporarily() {
	if [ -z "$blocked" ]; then
		echo "No blocked USB devices found."
		exit
	fi

	for i in "${!blocked[@]}"
	do
		 usbguard allow-device ${blocked[$i]}
		echo "Added device ${blocked[$i]} temporarily!"
	done
}

# if "-tmp" flag is not set, this function will permanently add the blocked device
add_permanently() {

	no_new_devices=true
	 chmod 600 /etc/usbguard/rules.conf

	for i in "${!id[@]}"
	do
		if ! grep -q "allow id ${id[$i]}" /etc/usbguard/rules.conf; then
			# matching both ID and name (doesn't always work)
			#  echo "allow id ${id[$i]} serial '' name ${name[$i]}" >> /etc/usbguard/rules.conf
			# matching ID only
			 echo "allow id ${id[$i]}" >> /etc/usbguard/rules.conf
			echo "Added device ${id[$i]} permanently on all ports!"
			no_new_devices=false
		fi
	done

	if [ "$no_new_devices" = true ]; then
    		echo "No new USB devices found."
	fi

	 systemctl restart usbguard 

	 chmod 400 /etc/usbguard/rules.conf
}

case "$1" in
	-t)
		add_temporarily
		;;
		
	-p)
		add_permanently
		;;

	*)
		add_temporarily
		;;
esac
