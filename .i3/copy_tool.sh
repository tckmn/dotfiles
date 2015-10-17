echo -n "$(zenity --list --text 'Copy what?' --hide-header --column x \
    ​ \
    ಠ_ಠ \
    '( ͡° ͜ʖ ͡°)' \
    '(╯°□°）╯︵ ┻━┻' \
    '¯\_(ツ)_/¯' \
)" \
| perl -e 'my $s = do { local $/; <STDIN> }; $s =~ s/(.*)\|\1/\1/s; print $s' \
| xsel -ib
# the perl weirdness is necessary because of a zenity bug:
# https://bugs.launchpad.net/ubuntu/+source/zenity/+bug/1267788
