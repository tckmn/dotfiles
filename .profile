for pathdir in "$HOME/bin" "$HOME/.gem/ruby/2.3.0/bin"
do
    if [ -d "$pathdir" ]
    then
        export PATH="$PATH:$pathdir"
    fi
done

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
