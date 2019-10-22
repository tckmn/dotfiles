for pathdir in "$HOME/bin" "$HOME/.config/i3/bin"
do
    [ -d "$pathdir" ] && export PATH="$pathdir:$PATH"
done

export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"
export TEXMFHOME="$HOME/.local/share/texmf"
export LC_TIME=C
export PRINTER=mitprint
export TERMINAL="$(which termite)"
