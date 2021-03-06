# For testing
# set -x
# set -u

## A few global settings
# + check the window size after each command and, if necessary,
#   update the values of LINES and COLUMNS.
# + learn the damn Emacs bindings at least a little
# + don't offer command completion on empty lines
# + set term type and CLICOLOR
# + set MAILDIR for mu
shopt -s checkwinsize
set -o emacs
shopt -s no_empty_cmd_completion
export CLICOLOR=1
export MAILDIR=$HOME/.maildir

## Includes
[[ -f $HOME/.bash_aliases ]] && source $HOME/.bash_aliases

[[ -f $HOME/.bash_functions ]] && source $HOME/.bash_functions

bc="$HOME/local/bash-completion-1.99/share/bash-completion/bash_completion"
[[ -f $bc ]] && source $bc

[[ -f $HOME/.bash_completion ]] && source $HOME/.bash_completion

[[ -f /usr/local/Library/Contributions/brew_bash_completion.sh ]] \
    && source /usr/local/Library/Contributions/brew_bash_completion.sh

[[ -f $HOME/.amazon_keys ]] && source $HOME/.amazon_keys

## History settings
# + bigger is better
# + no dups; no lines starting with a space
# + handle multiple sessions sanely
# + save multi-line commands as a single line
# + :...; turns the timestamp into a "do-nothing" command
export HISTSIZE=1000
export HISTCONTROL=ignoreboth
shopt -s histappend cmdhist
export HISTTIMEFORMAT=': %Y-%m-%d %I:%M:%S; '

## Editor settings
export SVN_EDITOR=vim
export GIT_EDITOR='mvim -f -c"au VimLeave * !open -a Terminal"'
export EDITOR=vim

# Use CDPATH to make life better
CDPATH=::$HOME:$HOME/code
INFOPATH=/usr/local/share/info:$INFOPATH
INFODIR=/usr/local/share/info:$INFODIR

## Perl varia
# put perlbrew where I want it and source it
# defaults for cpanminus
export PERLBREW_ROOT=$HOME/.perl5/perlbrew
if [[ -f $HOME/.perl5/perlbrew/etc/bashrc ]]; then
    source $HOME/.perl5/perlbrew/etc/bashrc
fi
export PERL_CPANM_OPT="--mirror file:///$HOME/.minicpan\
    --mirror http://cpan.cpantesters.org"

## The prompt below gets ideas from the following:
# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
# http://github.com/adamv/dotfiles/blob/master/bashrc
# http://wiki.archlinux.org/index.php/Color_Bash_Prompt
txtred='\[\e[0;31m\]' # Red
txtwht='\[\e[0;37m\]' # White
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldwht='\[\e[1;37m\]' # White
bldcyn='\[\e[1;36m\]' # Cyan
end='\[\e[0m\]'       # Text Reset

set_titlebar() {
    case $TERM in
        *xterm*|ansi|rxvt)
            printf "\033]0;%s\007" "$*"
            ;;
    esac
}

get_dir() {
    printf "%s" $(pwd | sed "s:$HOME:~:")
}

get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto git"

export PS1='\u \W$(__git_ps1 " [%s $(get_sha)]")\$ '
export PROMPT_COMMAND='set_titlebar "$USER@${HOSTNAME%%.*} $(get_dir)"'

## Pager stuff
# MANPAGER=less
# export MANPAGER
export PAGER=less
LESS='-GRJx4P?f[%f]:[STDIN].?pB - [%pB\%]:\.\.\..'
export LESS
[[ -e /usr/local/bin/lesspipe ]] \
    && LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
export LESSOPEN

[[ -d $HOME/bin ]] && export PATH=$PATH:$HOME/bin

[[ -x $HOME/bin/rbfu ]] && eval "$(rbfu --init)"

[[ -d "/Applications/Postgres.app" ]] &&
	PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# Set up JS-Test-Driver
export JSTESTDRIVER_HOME=$HOME/bin
# export HOMEBREW_VERBOSE=1
# export HOMEBREW_USE_GCC=1
# export CC=gcc-4.2
# export CXX=g++-4.2
[[ -f $HOME/.lua_config.lua ]] && export LUA_INIT="@$HOME/.lua_config.lua"
command -v luarocks >/dev/null && eval "$(luarocks path)"
# [ -n "$TMUX"  ] && export TERM=screen-256color
