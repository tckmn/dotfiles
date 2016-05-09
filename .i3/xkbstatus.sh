#!/bin/bash
setxkbmap -query |
    awk '/layout/{print $2}' |
    awk -F, '{gsub(".*","[&]",$'$[$(~/.i3/xkbgroup;echo $?)+1]')}{print $0}'
