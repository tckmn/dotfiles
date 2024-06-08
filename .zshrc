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
eval "$(dircolors -b)"
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

# aliases / functions
alias sudo='sudo '
alias sc=systemctl
alias scu='systemctl --user'
alias srn='systemctl restart iwd'
alias srb='systemctl restart bluetooth'
alias ms='systemctl --user start mbsync'
alias rf='resolvectl flush-caches'
alias lsa='printf "%s\n" "${(k)aliases[@]}" | sort'
alias lsb='printf "%s\n" "${(k)builtins[@]}" | sort'
alias lsc='printf "%s\n" "${(k)commands[@]}" | sort'
alias lsf='printf "%s\n" "${(k)functions[@]}" | sort'
alias sum="awk '{s+=\$1}END{print s}'"
alias prod="awk 'BEGIN{p=1}{p*=\$1}END{print p}'"
alias len="awk '{print length(\$0), \$0}'"
alias lens="awk '{print length(\$0), \$0}' | sort -n"
alias lc='tr A-Z a-z'
alias uc='tr a-z A-Z'
alias tal='sort | uniq -c | sort -n'
alias talr='sort | uniq -c | sort -nr'
alias kaero='fold -1 | tal'
alias nr='nix repl "<nixpkgs>"'
alias ape='nix-shell --run "autoPatchelf ." -p autoPatchelfHook'
alias bn='nix-build --option build-use-sandbox true -A'
br() { nix-build --option build-use-sandbox true -E "(import <nixpkgs> {}).callPackage ./pkgs/$1 {}" }
b() { [ -n "$1" ] && \light -S "$1" || light -G }
comms() { comm "$1" <(sort "$2") <(sort "$3") }
alias v=$(which nvim >/dev/null && echo nvim || echo vim)
xv() {
    [ -e "$1" ] && echo Warning: file exists && sleep 2
    touch "$1" && chmod +x "$1" && v "$1"
}
alias feh='feh --action1 "echo -n %F | xsel -ib"'
alias frink='rlwrap -H ~/.frink_history java -cp ~/misc/frink.jar frink.parser.Frink'
alias ws='watch -n0.1 echo '"'"'${LINES}x$COLUMNS'"'"
alias qmv='qmv -fdo'
alias qcp='qcp -fdo'
alias lhd='lighttpd -f lighttpd.conf'
alias tck='mutt -F ~/.config/mutt/tck_muttrc'
alias z='zathura --fork'
alias python=python3
да(){yes ${@:-д}}
dump() { objdump -sj .text $1 | tail -n+5 | cut -c 10-44 | tr -d ' ' | paste -sd '' }
alias pd='sqlite3 ~/.local/share/pzplus/p.db'
alias pon='xmodmap -e "pointer = 1 2 3 4 5 6 7 8 9 10"'
alias pof='xmodmap -e "pointer = 1 2 3 4 5 6 7 8 0 10"'
mouse() { xinput set-prop "$(xinput | grep -i mouse | head -1 | grep -o 'id=[0-9]*' | cut -c 4-)" 177 $1 0 0 0 $1 0 0 0 1 }
tp() { xinput ${1}able "$(xinput | grep Touchpad | grep -o 'id=\S*' | cut -c4-)" }

# licenses
if [ -d ~/.license ]
then
    < <(find -L ~/.license/ -type f) while read license
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
# fancy globs
setopt extendedglob
# make completion competent
setopt menu_complete
bindkey "${terminfo[kcbt]}" reverse-menu-complete

# prompt
PS1="$([ -n "$IN_NIX_SHELL" ] && echo 'nix-shell:')%K{red}%F{white}%n@%m%f%k:%B%F{cyan}%(4~|...|)%3~%F{white}%(!.#.$) %b%f%k"
RPROMPT=

# ssh-agent
if [ $(find ~/.ssh -iname '*.pub' -printf x) ] && which ssh-agent >/dev/null
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

incog-ret() {
    BUFFER=" $BUFFER"
    zle accept-line
}
incog() {
    zle -N incog-ret
    bindkey '^M' incog-ret
}

# arduino exports
export ARDUINO_DIR=/usr/share/arduino
export ARDMK_DIR=/usr/share/arduino
export AVR_TOOLS_DIR=/

# gpg/git exports
export GPG_TTY=$(tty)

export stm=~/.steam/steam/steamapps/common
export SSH_ASKPASS=
