for pathdir in "$HOME/bin"
do
    if [ -d "$pathdir" ]
    then
        export PATH="$pathdir:$PATH"
    fi
done

export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"
export TEXMFHOME="$HOME/.local/share/texmf"
export LC_TIME=C
export PRINTER=mitprint
export TERMINAL="$(which termite)"
