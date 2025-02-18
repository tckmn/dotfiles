#!/usr/bin/env bash

name="$(~/.config/i3/bin/vinput "$(sed 's/ /_/g' <<<"$1")" +'inoremap <space> _' +'norm f.')"
[ $? -eq 0 ] || exit $?
if [ "$name" = /dev/null ]
then
    echo
    rm -v "$1"
    echo
elif [ -n "$name" ]
then
    echo
    mv --debug -n "$1" "$name"
    echo
fi
