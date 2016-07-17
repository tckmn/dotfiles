# identify ourselves
export TERM=screen-256color

# keep lots of history within the shell and save it to ~/misc/ZSH_HISTORY
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/misc/ZSH_HISTORY

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
    title "$TITLE_PREFIX$1 [$(pwd)]"
}

# fun
alias cmatrix="cmatrix -b"
alias xcowsay="xcowsay -f monospace"
function atcrec() {
    ttyrec "$(date "+atc_%F_%T.ttyrec")" -e "TERM=xterm atc -g ${1:-default}"
}

# 1 or 2 screens
alias 1s="xrandr --auto"
alias 2s="xrandr --auto && xrandr --output HDMI2 --right-of eDP1"

# etc aliases
alias printer='lp -d home_printer'
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
alias n='(cat;echo)'
alias sc=systemctl
alias scu='systemctl --user'

which thefuck >/dev/null && eval "$(thefuck -a pls)"

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

# prompts
PS1="%K{red}%F{white}%n@%m%f%k:%B%F{cyan}%(4~|...|)%3~%F{white}%(!.#.$) %b%f%k"

command_not_found_handler() {
    echo "zsh: command not found: $1"
    if which notify-send >/dev/null
    then
        (
            pkgname="$(pacman -Fo "usr/bin/$1")"
            if [ -n "$pkgname" ]
            then
                notify-send 'zsh: pacman package available' "$pkgname"
            fi
        ) &
    fi
}

if which ssh-agent >/dev/null
then
    if pgrep ssh-agent >/dev/null
    then
        . ~/.cache/ssh-agent >/dev/null
    else
        ssh-agent > ~/.cache/ssh-agent
        . ~/.cache/ssh-agent >/dev/null
        find ~/.ssh/ -iname '*.pub' -exec bash -c \
            'ssh-add ~/.ssh/"$(basename {} | head -c -5)"' \;
    fi
fi

for binding in $(bindkey | awk '{print $NF}' | sort -u \
    | grep -v '^accept\|complete\|run-help')
do
    eval "$binding () {
        POSTDISPLAY=
        zle .$binding"'
        [ -n "$DISABLE_AUTOSUGGEST" ] && return
        if [ "$BUFFER" = "g " -o "$BUFFER" = "gi " ]
        then
            BUFFER="git "
            zle .end-of-line
        elif [[ "$BUFFER" == git\ ?* ]]
        then
            for cmd in "git add" "git branch" "git commit" "git checkout" \
                "git clone" "git clean" "git diff" "git fetch" "git init" \
                "git log" "git merge" "git push" "git pull" "git reset" \
                "git revert" "git rebase" "git status" "git stash"
            do
                if [[ "$cmd" == $BUFFER* ]]
                then
                    POSTDISPLAY=${cmd#$BUFFER}
                    break
                fi
            done
        fi
        region_highlight=("$#BUFFER $(($#BUFFER+$#POSTDISPLAY)) fg=8")
    }'
    zle -N $binding
done

accept-line() {
    BUFFER="$BUFFER$POSTDISPLAY"
    region_highlight=
    POSTDISPLAY=
    DISABLE_AUTOSUGGEST=
    zle .accept-line
}
zle -N accept-line

accept-line-raw() {
    region_highlight=
    POSTDISPLAY=
    DISABLE_AUTOSUGGEST=
    zle .accept-line
}
zle -N accept-line-raw
bindkey '^[^M' accept-line-raw

toggle-autosuggest() {
    region_highlight=
    POSTDISPLAY=
    DISABLE_AUTOSUGGEST=1
}
zle -N toggle-autosuggest
bindkey '^@' toggle-autosuggest

accept-autosuggest() {
    if [ -n "$POSTDISPLAY" ]
    then
        BUFFER="$BUFFER$POSTDISPLAY "
        region_highlight=
        POSTDISPLAY=
        DISABLE_AUTOSUGGEST=
        zle .end-of-line
    elif [[ $BUFFER =~ ^[.]{1,}$ ]]
    then
        BUFFER="$(perl -pe 's| ?(\.+)$|"../"x(length$1)|e'<<<"$BUFFER")"
        zle .end-of-line
    else
        zle expand-or-complete
    fi
}
zle -N accept-autosuggest
bindkey '^I' accept-autosuggest

# http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z() {
    if [ $#BUFFER -eq 0 ]; then
        BUFFER="fg"
        zle accept-line
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
