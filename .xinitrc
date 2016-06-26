xrdb /home/llama/.Xresources
setxkbmap -layout us,ru
setxkbmap -option ctrl:nocaps -option compose:rctrl -option grp:toggle
xcape
xss-lock -- i3lock -c 181818 &
dunst &

exec i3
