#!/bin/sh
while [[ -z found ]]; do
	if [[ -f metadata.config ]]; then
		. ./metadata.config
		found="$bug_id"
	fi

	cd ..
done

echo $found

