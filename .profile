for pathdir in "$HOME/.gem/ruby/2.3.0/bin" "$HOME/bin"
do
    if [ -d "$pathdir" ]
    then
        export PATH="$pathdir:$PATH"
    fi
done

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export TEXMFHOME="$HOME/.local/share/texmf"
export LC_TIME=C
