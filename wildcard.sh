#!/bin/bash
# Installation guide:
# put a file "wildcard.desktop" in
# 
# ~/.local/share/applications/wildcard.desktop
#
# containing the following (note the variable you have to replace)
#
# [Desktop Entry]
# Type=Application
# Version=1.0
# Name=wildcard
# Path=$path_to_wildcard_sh
# Exec=wildcard.sh
# Terminal=false
#
# associate all known mime types with the program (or rather, the desktop file), execute:
#
# xdg-mime default wildcard.desktop $(cat /usr/share/mime/types)
#
# associate with magnet scheme
#
# xdg-mime default wildcard.desktop x-scheme-handler/magnet

readonly input_filename="$1"
readonly input_mime="$(xdg-mime query filetype "$input_filename")"

echo "input: $input_filename" >> /tmp/wildcard_output
echo "mime: $input_mime" >> /tmp/wildcard_output

function determine_terminal() {
    if [[ $TERMINAL != "" ]]; then
	echo "$TERMINAL"
    else
	echo xterm
    fi
}

readonly terminal="$(determine_terminal)"

function open_directory() {
    local dirname="$1"
    cd "$input_filename"
    $terminal
}

# see http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
function program_exists() {
    local program="$1"
    command -v $program >/dev/null 2>&1
}

function output_error_message() {
    local message="$1"
    local title="wildcard.sh error"
    if program_exists zenity; then
	zenity --error --title="$title" --text="$message"
    elif program_exists dialog; then
	$terminal -e "dialog --msgbox \"$message\" 0 0"
    else
	echo "$message" >> /tmp/wildcard_error
    fi
}

function open_archive() {
    local filename="$1"

    if program_exists file-roller; then
       file-roller "$filename" || output_error_message "error opening file-roller";
    else
	open_directory "$(basename "$filename")"
    fi
}

function open_video() {
    local filename="$1"

    if program_exists mpv; then
	mpv "$filename" || output_error_message "error opening mpv"
    elif program_exists mplayer; then
	mplayer "$filename" || output_error_message "error opening mplayer"
    elif program_exists mplayer2; then
	mplayer2 "$filename" || output_error_message "error opening mplayer2"
    elif program_exists totem; then
	totem "$filename" || output_error_message "error opening totem"
    else
	output_error_message "No video player found"
    fi
}

function open_image() {
    local filename="$1"

    if program_exists display; then
	display "$filename" || output_error_message "error opening display"
    elif program_exists feh; then
	feh "$filename" || output_error_message "error opening feh"
    else
	output_error_message "No image viewer found"
    fi
}

function open_browser() {
    local filename="$1"

    if [[ $BROWSER != "" ]]; then
	if program_exists "$BROWSER"; then
	    $BROWSER "$filename"
	else
	    output_error_message "\$BROWSER is set, but does not point to an executable"
	fi
    fi

    if program_exists google-chrome; then
	google-chrome "$filename" || output_error_message "error opening google-chrome"
    elif program_exists google-chrome-stable; then
	google-chrome-stable "$filename" || output_error_message "error opening google-chrome-stable"
    else
	output_error_message "No browser found"
    fi
}

function emacs_server_is_running() {
    test -e "/tmp/emacs1000/server" || test -e "~/.emacs.d/server"
}

function open_text() {
    # prio 1, if emacs server is running, use that
    # otherwise if gvim exists, open that
    # otherwise if vim exists, open a terminal with that
    # otherwise use the fucking browser
    if emacs_server_is_running; then
	emacsclient "$1";
    elif program_exists gvim; then
	gvim "$1" || output_error_message "error running gvim"
    elif program_exists vim; then
	$terminal -e "vim \"$1\""
    else
	open_browser "$1"
    fi
}

function open_magnet() {
    if program_exists transmission-gtk; then
	transmission-gtk "$1" || output_error_message "error starting transmission-gtk"
    else
	output_error_message "no magnet handlers available"
    fi
}

if [[ $input_mime == "" ]]; then
    if [[ $input_filename =~ ^magnet: ]]; then
	open_magnet "$input_filename";
    else
	output_error_message "mime empty, name was \"$input_filename\""
    fi
fi

case $input_mime in
    "inode/directory" | "inode/mount-point")
	open_directory "$input_filename"
	;;
    "application/x-7z-compressed" | "application/x-7z-compressed-tar" | "application/x-ace" | "application/x-alz" | "application/x-ar" | "application/x-arj" | "application/x-bzip" | "application/x-bzip-compressed-tar" | "application/x-bzip1" | "application/x-bzip1-compressed-tar" | "application/x-cabinet" | "application/x-cbr" | "application/x-cbz" | "application/x-cd-image" | "application/x-compress" | "application/x-compressed-tar" | "application/x-cpio" | "application/x-deb" | "application/x-ear" | "application/x-ms-dos-executable" | "application/x-gtar" | "application/x-gzip" | "application/x-gzpostscript" | "application/x-java-archive" | "application/x-lha" | "application/x-lhz" | "application/x-lrzip" | "application/x-lrzip-compressed-tar" | "application/x-lzip" | "application/x-lzip-compressed-tar" | "application/x-lzma" | "application/x-lzma-compressed-tar" | "application/x-lzop" | "application/x-lzop-compressed-tar" | "application/x-ms-wim" | "application/x-rar" | "application/x-rar-compressed" | "application/x-rpm" | "application/x-rzip" | "application/x-rzip-compressed-tar" | "application/x-tar" | "application/x-tarz" | "application/x-stuffit" | "application/x-war" | "application/x-xz" | "application/x-xz-compressed-tar" | "application/x-zip" | "application/x-zip-compressed" | "application/x-zoo" | "application/zip" | "application/x-archive" | "application/vnd.ms-cab-compressed")
	open_archive "$input_filename"
	;;
    "application/ogg" | "application/x-ogg" | "application/sdp" | "application/smil" | "application/x-smil" | "application/streamingmedia" | "application/x-streamingmedia" | "application/vnd.rn-realmedia" | "application/vnd.rn-realmedia-vbr" | "audio/aac" | "audio/x-aac" | "audio/m4a" | "audio/x-m4a" | "audio/mp1" | "audio/x-mp1" | "audio/mp2" | "audio/x-mp2" | "audio/mp3" | "audio/x-mp3" | "audio/mpeg" | "audio/x-mpeg" | "audio/mpegurl" | "audio/x-mpegurl" | "audio/mpg" | "audio/x-mpg" | "audio/rn-mpeg" | "audio/ogg" | "audio/scpls" | "audio/x-scpls" | "audio/vnd.rn-realaudio" | "audio/wav" | "audio/x-pn-windows-pcm" | "audio/x-realaudio" | "audio/x-pn-realaudio" | "audio/x-ms-wma" | "audio/x-pls" | "audio/x-wav")
	open_video "$input_filename"
	;;
    video/*)
	open_video "$input_filename"
	;;
    audio/*)
	open_audio "$input_filename"
	;;
    image/*)
	open_image "$input_filename"
	;;
    text/html)
	open_browser "$input_filename"
	;;
    text/*)
	open_text "$input_filename"
	;;
    # TODO: torrent files
    *)
	output_error_message "association not found for file \"$input_filename\", mime \"$input_mime\""
	;;
esac
