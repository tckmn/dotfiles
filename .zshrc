# identify ourselves
export TERM=screen-256color

# keep lots of lines of history within the shell and save it to
# ~/misc/ZSH_HISTORY
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/misc/ZSH_HISTORY

# colors!
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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

# http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
    if [ $#BUFFER -eq 0 ]; then
        BUFFER="fg"
        zle accept-line
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

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
alias bsdgames="apt show bsdgames | tail -n6"
alias cmatrix="cmatrix -b -u 9"
alias xcowsay="xcowsay -f monospace"
alias nao="ssh nethack@nethack.alt.org"
alias sl="sl -e"
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
alias midi='aplaymidi -p 14:0'
alias n='(cat;echo)'

# allow use of comments in shell
setopt interactivecomments

# prompts
PS1="%K{red}%F{white}%n@%m%f%k:%B%F{cyan}%(4~|...|)%3~%F{white}%(!.#.$) %b%f%k"
#RPS1="%*"

# this is really awesome
# what I'm doing here is arbitrarily preprocessing commands before executing
# them---WAY more powerful than aliasing
if [ -f ~/.cmdline_intercept ]
then
    cmdline_intercept () {
        BUFFER="$(~/.cmdline_intercept "$BUFFER")"
        zle accept-line
    }
    zle -N cmdline_intercept
    bindkey '^M' cmdline_intercept
fi
