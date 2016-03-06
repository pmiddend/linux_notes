#!/bin/bash

readonly input_filename="$1"
readonly input_mime="$(xdg-mime query filetype "$input_filename")"

echo "input: $input_filename" >> /tmp/wildcard_output
echo "mime: $input_mime" >> /tmp/wildcard_output

function open_directory() {
    local dirname="$1"
    cd "$input_filename"
    xterm
}

case $input_mime in
    "inode/directory")
	open_directory "$input_filename"
					  ;;
    "inode/mount-point")
	open_directory "$input_filename"
					  ;;
esac
