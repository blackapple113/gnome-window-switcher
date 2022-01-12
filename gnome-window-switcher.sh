#!/bin/bash

get_switch_windows="$(gsettings get org.gnome.desktop.wm.keybindings switch-windows)"
get_switch_windows_backward="$(gsettings get org.gnome.desktop.wm.keybindings switch-windows-backward)"

switch_windows_key="['<Alt>Tab']"
switch_windows_backward_key="['<Shift><Alt>Tab']"
switch_applications_key="['<Super>Tab']"
switch_applications_backward_key="['<Shift><Super>Tab']"

set_alt_tab() {
    gsettings set org.gnome.desktop.wm.keybindings switch-windows "$switch_windows_key"
    gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "$switch_windows_backward_key"
    gsettings set org.gnome.desktop.wm.keybindings switch-applications "$switch_applications_key"
    gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "$switch_applications_backward_key"
}

reset_alt_tab() {
    gsettings reset org.gnome.desktop.wm.keybindings switch-windows
    gsettings reset org.gnome.desktop.wm.keybindings switch-windows-backward
    gsettings reset org.gnome.desktop.wm.keybindings switch-applications
    gsettings reset org.gnome.desktop.wm.keybindings switch-applications-backward
}

argument=$1
case $argument in
    -r | --reset)
        reset_alt_tab
        exit
        ;;
    -h | --help | -* | --*)
        echo "With no options set the programm will set or overwrite (you will get asked) the options to switch between windows and not applications. To reset to default settings you have to use --reset option."
        echo 
        echo "Usage:"
        echo "  $0 [--reset]"
        echo
        echo "Options:"
        echo "  -h, --help:       shows this help"
        echo "  -r, --reset:      resets the keyboard settings for switching applications"
        exit
        ;;
esac

if [[ $get_switch_windows != "@as []" ]] || [[ $get_switch_windows_backward != "@as []" ]]
then
    while true; do
        echo "One of the switch windows settings is allready set."
        echo "If you continue you will overwrite existing settings."
        read -p 'Overwrite existing settings? (y/n): ' yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) exit;;
            * ) echo "No valid Input was given!";;
        esac
    done
fi

set_alt_tab
