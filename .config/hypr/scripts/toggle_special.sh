#!/bin/bash

status=`cat ~/.cache/personal-stuff/focus`

if [[ $status == "true" ]]; then
	rm ~/.config/hypr/focus_status.conf
	ln -s ~/.config/hypr/configs/unfocus.conf ~/.config/hypr/focus_status.conf
	echo false > ~/.cache/personal-stuff/focus
	hyprctl reload
elif [[ $status == "false" ]]; then
	rm ~/.config/hypr/focus_status.conf
	ln -s ~/.config/hypr/configs/focus.conf ~/.config/hypr/focus_status.conf
	echo true > ~/.cache/personal-stuff/focus
	hyprctl reload
fi
