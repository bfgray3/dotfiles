case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

function git_branch() {
    git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/.*/ (&)/'
}

function virtualenv_string() {
    if [[ -n "$VIRTUAL_ENV" ]]
    then
        echo "(${VIRTUAL_ENV##*/}) "
    fi
}

function make_command_prompt() {
    local exit_status="$?"

    PS1="$(virtualenv_string)\[\033[1;36m\]\D{%F %T} \[\033[32m\]\u\]@\h:\w\[\033[33m\]\$(git_branch)\n"

    if [[ "$exit_status" -eq 0 ]]
    then
        PS1+="\[\033[32m\]$\[\033[0m\] "
    else
        PS1+="\[\033[31m\]!\[\033[0m\] "
    fi
}

PROMPT_COMMAND=make_command_prompt

if [[ -f ~/.bash_aliases ]]
then
    . ~/.bash_aliases
fi

export EDITOR=vim
export VISUAL=vim
export VIRTUALENV_NO_PERIODIC_UPDATE=1
