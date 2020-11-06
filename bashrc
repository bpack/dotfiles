# Aliases

alias ls='ls -F'
alias ll='ls -lF'
alias la='ls -alF'

alias py='python'


# Create a base64 encoded data URL from a file
dataurl() {
    local MIMETYPE=$(file --mime-type "$1" | cut -d ' ' -f2)
    if [[ $MIMETYPE == "text/*" ]]; then
        MIMETYPE="${MIMETYPE};charset=utf-8"
    fi
    echo "data:${MIMETYPE};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

unshorten() {
    curl -sIL $1 | sed -n 's/Location: *//p'
}

# https://meyerweb.com/eric/thoughts/2020/09/29/polite-bash-commands/
please() {
    if [ "$1" ]; then
        sudo $@
    else
        sudo "$BASH" -c "$(history -p !!)"
    fi
}

# Functions

function cd
{
    if [ $# -eq 0 ]; then
        pushd ~ > /dev/null
    elif [ " $1" = " -" ]; then
        pushd "$OLDPWD" > /dev/null
    else
        pushd "$@" > /dev/null
    fi
}

function mcd() {
    mkdir -p $1
    cd $1
}

function g() {
    ./gradlew "$@"
}


# The worktime and slacktime functions originate here
# http://samuelmullen.com/2013/10/the-two-most-productivity-enhancing-scripts-ever-written-in-the-history-of-unix/
# --

function worktime() {
    echo "# WORKTIME" | sudo tee -a /etc/hosts > /dev/null
    while read -r line; do
        echo "127.0.0.1 ${line}"
    done < $HOME/.blocked_sites | sudo tee -a /etc/hosts > /dev/null
}

function slacktime() {
    local flag=0
    while read -r line; do
        [[ $line =~ "# WORKTIME" ]] && flag=1
        [[ $flag -eq 1 ]] && continue
        echo $line
    done < /etc/hosts > /tmp/hosts

    sudo cp /tmp/hosts /etc/hosts
}

function _git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}

function _virtualenv_info(){
    local venv=''
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
        venv="${venv%-*}"
    fi
    [[ -n "$venv" ]] && echo "(venv: $venv) "
}

function _aws_profile(){
    local aws_prof=''
    if [[ -n "$AWS_PROFILE" ]]; then
        aws_prof="${AWS_PROFILE}"
    fi
    [[ -n "$aws_prof" ]] && echo "<aws: $aws_prof> "
}

function _prompt_command() {
    local BRANCH=`_git_branch`
    local LOAD=`uptime|awk '{min=NF-2;print $min}'`
    local VENV=`_virtualenv_info`
    local TIME='\t'
    local NEWLINE='\n'
    local PROFILE=`_aws_profile`

    local GREEN="\[\033[0;32m\]"
    local CYAN="\[\033[0;36m\]"
    local BCYAN="\[\033[1;36m\]"
    local BLUE="\[\033[0;34m\]"
    local GRAY="\[\033[0;37m\]"
    local DKGRAY="\[\033[1;30m\]"
    local WHITE="\[\033[0;37m\]"
    local RED="\[\033[0;31m\]"

    # return color to Terminal setting for text color
    local DEFAULT="\[\033[0;39m\]"
    export PS1="\n[\!] \t ${RED}(${LOAD}) ${GREEN}\w\n${BLUE}${PROFILE}${DEFAULT}${CYAN}${BRANCH}${RED}$VENV${DEFAULT}\$ "
}

PROMPT_COMMAND=_prompt_command

# OS specific bash extensions
if [ -f ~/.bash_ext ]; then
    source ~/.bash_ext
fi


# Created by `userpath` on 2020-10-24 12:51:29
export PATH="$PATH:/Users/bpack/.local/bin"
