chkfile="$HOME/.i3/__maybe_action"
if [ -f "$chkfile" ]
then
    i3-msg 'mode "action: (l)aunch  (s)ystem  (c)opy"'
else
    touch "$chkfile"
    sleep 0.3
fi
rm "$chkfile"
