xrdb /home/llama/.Xresources
setxkbmap -layout us,ru
setxkbmap -option ctrl:nocaps -option compose:rctrl -option grp:toggle
xmodmap -e "$(xmodmap -pke | grep 108 | sed 's/ISO_Level3_Shift/ISO_Next_Group/g')"
xcape
xss-lock -- i3lock -c 181818 &
dunst &

exec i3
