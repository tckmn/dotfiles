#!/usr/bin/env bash

stow -n .
echo -n 'continue? [yes/no] '
read cont
if [ "$cont" = yes ]
then
    stow .
    [ ! -e ~/.config/nvim ] && ln -Ts ~/.vim ~/.config/nvim
fi
