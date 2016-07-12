xrdb /home/llama/.Xresources
setxkbmap -layout us,ru
setxkbmap -option ctrl:nocaps -option compose:rctrl -option grp:toggle
xmodmap -e 'keycode 108 = ISO_Next_Group Meta_R ISO_Next_Group Meta_R'
xcape
xss-lock -- i3lock -c 181818 &
dunst &

exec i3
