# identify ourselves
export TERM=screen-256color

# keep lots of history within the shell and save it to ~/misc/ZSH_HISTORY
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

# sane alt+f / alt+b / ctrl+w behavior
WORDCHARS=${WORDCHARS/\/}

# colors!
eval "$([ -r ~/.dircolors ] && dircolors -b ~/.dircolors || dircolors -b)"
for cmd in ls dir vdir grep fgrep egrep
do
    alias $cmd="$cmd --color=auto"
done

# use modern completion system
autoload -Uz compinit
compinit

# emacs mode
bindkey -e

# some default completion magic
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# completion for the `kill' command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# http://stackoverflow.com/a/27643846/1223693
zstyle -e ':completion::complete:-command-::executables' ignored-patterns '
    [[ "$PREFIX" == ./* ]] && {
        local -a tmp; set -A tmp ./*(/)
        : ${(A)tmp::=${tmp// /\\ }}
        reply=(${(j:|:)tmp})
    }
'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# urxvt title
function title() { printf '\33]2;%s\007' "$1" }
function t {
    if [ -z "$@" ]
    then
        TITLE_PREFIX=
    else
        TITLE_PREFIX="{{$@}} "
    fi
}
function precmd {
    title "${TITLE_PREFIX}zsh [$(pwd)]"
}
function preexec {
    title "$TITLE_PREFIX${1//
/} [$(pwd)]"
}

# aliases / functions

alias cmatrix="cmatrix -b"
alias xcowsay="xcowsay -f monospace"

alias ws='watch -n0.1 echo '"'"'${LINES}x$COLUMNS'"'"

function xb() {
    [ -n "$1" ] && xbacklight -set "$1" || xbacklight
}

alias v='nvim'
function xv() {
    [ -e "$1" ] && echo Warning: file exists && sleep 1
    touch "$1" && chmod +x "$1" && v "$1"
}
alias vx=xv

alias sc=systemctl
alias scu='systemctl --user'
alias cku=checkupdates

alias sudo='sudo '

alias frink='rlwrap -H ~/.frink_history java -cp ~/misc/frink.jar frink.parser.Frink'
alias dip='code/py/dipperino/dipperino.py'
alias p='ps ax | grep plover\\.main | awk "{print \$1}" | xargs kill; plover & disown'
alias gcal='gcalcli calw'

да(){yes ${@:-д}}

un() {
    mkdir $1
    cp ~/misc/usacotemplate.cpp $1/$1.cpp
    sed -i "s/MEEMS/$1/;" $1/$1.cpp
}
uc() {
    g++ -std=c++11 -O3 *.cpp -o a
    ./a
    cat *.out
}

# licenses
if [ -d ~/.license ]
then
    < <(find ~/.license/ -type f) while read license
    do
        license="$(basename $license)"
        alias $license="[ -f LICENSE ] && echo 'file LICENSE exists' || \
            cat ~/.license/$license > LICENSE"
    done
fi

# allow use of comments in shell
setopt interactivecomments
# cd by trying to "execute" a directory
setopt autocd
# provide a way to run something without adding it to history
setopt histignorespace

# prompts
PS1="%K{red}%F{white}%n@%m%f%k:%B%F{cyan}%(4~|...|)%3~%F{white}%(!.#.$) %b%f%k"

if [[ "$USERNAME" =~ ^llama$ ]] && which ssh-agent >/dev/null
then
    if pgrep -u $UID ssh-agent >/dev/null
    then
        . ~/.cache/ssh-agent >/dev/null
    else
        ssh-agent > ~/.cache/ssh-agent
        . ~/.cache/ssh-agent >/dev/null
        find ~/.ssh/ -iname '*.pub' -exec bash -c \
            'ssh-add ~/.ssh/"$(basename {} | head -c -5)"' \;
    fi
fi

if [ -f ~/.shemicolon/shemicolon.zsh ]
then
    source ~/.shemicolon/shemicolon.zsh
fi

# http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z() {
    if [ $#BUFFER -eq 0 -a -n "$(jobs)" ]; then
        BUFFER="fg"
        zle accept-line
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
