#!/bin/bash
found=""

while [ -z "$found" ]; do
	if [ -f metadata.config ]; then
		. ./metadata.config
		echo "$repository_id"
		exit 0
	fi

	cd ..
done

exit 2

