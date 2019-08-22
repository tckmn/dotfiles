# identify ourselves
export TERM=xterm

# history
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

# sane alt+f / alt+b / ctrl+w behavior
bindkey -e
WORDCHARS=${WORDCHARS/\/}

# colors
eval "$([ -r ~/.dircolors ] && dircolors -b ~/.dircolors || dircolors -b)"
for cmd in ls {,v}dir {,f,e}grep; do alias $cmd="$cmd --color=auto"; done

# completion
autoload -Uz compinit
compinit
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
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# don't suggest directories on ./<tab>
# http://stackoverflow.com/a/27643846/1223693
zstyle -e ':completion::complete:-command-::executables' ignored-patterns '
    [[ "$PREFIX" == ./* ]] && {
        local -a tmp; set -A tmp ./*(/)
        : ${(A)tmp::=${tmp// /\\ }}
        reply=(${(j:|:)tmp})
    }
'

# urxvt title
title() { printf '\33]2;%s\007' "$1" }
precmd() { title "${TITLE_PREFIX}zsh [$(pwd)]" }
preexec() { title "$TITLE_PREFIX${1//
/} [$(pwd)]" }
t() {
    if [ -z "$@" ]
    then
        TITLE_PREFIX=
    else
        TITLE_PREFIX="{{$@}} "
    fi
}

# aliases / functions for builtins / system tools
alias sudo='sudo '
alias sc=systemctl
alias scu='systemctl --user'
alias cku=checkupdates
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsa='printf "%s\n" "${(k)aliases[@]}" | sort'
alias lsb='printf "%s\n" "${(k)builtins[@]}" | sort'
alias lsc='printf "%s\n" "${(k)commands[@]}" | sort'
alias lsf='printf "%s\n" "${(k)functions[@]}" | sort'
alias sb='nix-build --option build-use-sandbox true -A'
xb() { [ -n "$1" ] && xbacklight -set "$1" || xbacklight }
comms() { comm "$1" <(sort "$2") <(sort "$3") }

# vim aliases
alias v='nvim'
xv() {
    [ -e "$1" ] && echo Warning: file exists && sleep 1
    touch "$1" && chmod +x "$1" && v "$1"
}
alias vx=xv

# user command aliases
alias cmatrix="cmatrix -b"
alias xcowsay="xcowsay -f monospace"
alias frink='rlwrap -H ~/.frink_history java -cp ~/misc/frink.jar frink.parser.Frink'
alias dip='code/py/dipperino/dipperino.py'
alias ws='watch -n0.1 echo '"'"'${LINES}x$COLUMNS'"'"
alias qmv='qmv -fdo'
alias qcp='qcp -fdo'
alias mutta='mutt -F ~/.config/mutt/kbd_muttrc'
alias muttb='mutt -F ~/.config/mutt/mit_muttrc'
alias muttc='mutt -F ~/.config/mutt/tck_muttrc'
alias python=python3
да(){yes ${@:-д}}
dump() { objdump -sj .text $1 | tail -n+5 | cut -c 10-44 | tr -d ' ' | paste -sd '' }
gcal() { gcalcli calw ${@:-4} }

# dumb stuff
alias es='zathura ~/doc/dict/spanish.pdf'
alias ru='zathura ~/doc/dict/russian.pdf'

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

# prompt
PS1="%K{red}%F{white}%n@%m%f%k:%B%F{cyan}%(4~|...|)%3~%F{white}%(!.#.$) %b%f%k"
RPROMPT=

# ssh-agent
if [[ "$USERNAME" =~ ^tckmn$ ]] && which ssh-agent >/dev/null
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

if [ -f ~/.shemicolon/shemicolon.zsh ]; then source ~/.shemicolon/shemicolon.zsh; fi
# if pgrep -u $UID frinkserver >/dev/null; then :; else ~/.frinkserver/frinkserver & disown; fi

command_not_found_handler() {
    if [[ "$1" =~ ^[0-9] ]]
    then
        echo whee
        return 0
    fi

    printf >&2 "zsh: command not found: %s\n" "$1"
    return 127
}

# http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z() {
    if [ $#BUFFER -eq 0 -a -n "$(jobs)" ]; then
        BUFFER="fg"
        zle accept-line
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# arduino exports
export ARDUINO_DIR=/usr/share/arduino
export ARDMK_DIR=/usr/share/arduino
export AVR_TOOLS_DIR=/

# gpg/git exports
export GPG_TTY=$(tty)
