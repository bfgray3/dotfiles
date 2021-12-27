case $- in
    *i*) ;;
      *) return;;
esac

export BASH_SILENCE_DEPRECATION_WARNING=1

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

### ALIASES ###
# TODO: put these in an apple-specific .bash_aliases?
alias lt='ls -GFlth'
alias l='ls -GFlh'
alias la='ls -GFAlh'
alias r='R --vanilla'
alias p='PYTHONASYNCIODEBUG=1 PYTHONTRACEMALLOC=1 python3'
alias repos='cd ~/repos'
