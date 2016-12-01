xrdb /home/llama/.Xresources

export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim
uim-xim &
export XMODIFIERS='@im=uim'
uim-toolbar-gtk3-systray &

xss-lock -- i3lock -c 181818 &

dunst &

exec i3
