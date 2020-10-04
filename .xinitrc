#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

export XSESSION_PID="$$"

# SESSION=${1:-xfce}

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


# Starting programs
# if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#     for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#         [ -x "$f" ] && . "$f"
#     done
#     unset f
# fi

# 	local dbus_args=(--sh-syntax --exit-with-session)
# 	case "$SESSION" in
# 		awesome) dbus_args+=(awesome) ;;
# 		bspwm) dbus_args+=(bspwm-session) ;;
# 		budgie) dbus_args+=(budgie-desktop) ;;
# 		cinnamon) dbus_args+=(cinnamon-session) ;;
# 		deepin) dbus_args+=(startdde) ;;
# 		enlightenment) dbus_args+=(enlightenment_start) ;;
# 		fluxbox) dbus_args+=(startfluxbox) ;;
# 		gnome) dbus_args+=(gnome-session) ;;
# 		i3|i3wm) dbus_args+=(i3 --shmlog-size 0) ;;
# 		jwm) dbus_args+=(jwm) ;;
# 		kde) dbus_args+=(startkde) ;;
# 		lxde) dbus_args+=(startlxde) ;;
# 		lxqt) dbus_args+=(lxqt-session) ;;
# 		mate) dbus_args+=(mate-session) ;;
# 		xfce) dbus_args+=(xfce4-session) ;;
# 		openbox) dbus_args+=(openbox-session) ;;
# 		*) dbus_args+=("$SESSION") ;;
# 	esac

# 	echo "dbus-launch ${dbus_args[*]}"
# }

# Set audio profile in case it doesnt set the correct one
pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo+input:analog-stereo &

# SET WALLPAPER AND THEMES
# If you want it done in .xprofile
# [ -f ~/.xprofile ] && . ~/.xprofile

xwallpaper --zoom ~/.config/wall.png    # Sets wallpaper

# wal --theme base16-porple               # Runs wal to set xresources theme
# wal -i /home/aaqsr/Pictures/Wallpapers/Nature/derrick-cooper-L505cPnmIds-unsplash.jpg
# wal -i ~/.config/wall.png #--backend schemer2
# wal -i ~/.config/pywall.png
# wal --theme base16-eighties
wal -i ~/.config/wall.png

exec picom &                            # Transparency
# exec dwmbarupdater &                    # For the status bar
exec caps_esc &                         # Executes my script to turn caps into esc
exec sxhkd &                            # Starts sxhkd (for keybindings and hotkeys)
exec lxsession &                        # Starts the lxsession polkit (mostly for virt-manager)

# START WM
nvidia-settings --load-config-only
exec xfwm4
