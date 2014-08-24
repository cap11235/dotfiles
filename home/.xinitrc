xrandr --output HDMI3 --primary --pos 1080x440
xrandr --output HDMI1 --rotate right --pos 0x0
xrandr --output VGA1 --pos 3000x440
xrandr --dpi 96
pulseaudio --start
#xrdb ~/.Xdefaults
exec xmonad
