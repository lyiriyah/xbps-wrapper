#!/usr/bin/env bash

help() {
	echo "Usage: xbps [COMMAND] [ARGUMENTS]
Conglomerates xbps commands into one helper script.

install 	install packages. equivalent to xbps-install <arguments>
remove		remove packages. equivalent to xbps-remove -ROo <arguments>
update		update packages. equivalent to xbps-install -Su
search		search repositories. equivalent to xbps-query -Rs <arguments>
files		show package contents. equivalent to xbps-query -f <arguments>
locate		locate a file in all packages. equivalent to xlocate <arguments>
help, -h 	this help text

In most cases <arguments> is equivalent to \"\${@:2}\"."
}

case $1 in
	"install") xbps-install "${@:2}" ;;
	"remove") xbps-remove -ROo "${@:2}" ;;
	"update") xbps-install -Su ;;
	"search") xbps-query -Rs "${@:2}" ;;
	"files") xbps-query -f "${@:2}" ;;
	"locate") 
		xbps-query -S xtools > /dev/null 2&>1
		if [[ $? -eq 2 ]]; then
			echo xtools must be installed to continue.
			sudo xbps-install xtools
		fi
	
		echo Updating xlocate...
		xlocate -S > /dev/null 2&>1
		xlocate "${@:2}"
		;;
	"help"|"-h"|""|" ") help ;;
	*) echo "xbps: unrecognised option $1
Try 'xbps help' for more information."
esac
