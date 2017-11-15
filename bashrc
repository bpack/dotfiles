export TOOLS_HOME=~/Code/tools
export EDITOR=/usr/local/bin/vim
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export JAVA_HOME=$(/usr/libexec/java_home)
export OKTA_AWS_HOME=$TOOLS_HOME/okta-aws-cli-assume-role/out/

export PATH=/usr/local/opt/python/libexec/bin:$PATH:./node_modules/.bin:~/Code/bin

# Aliases

alias ls='ls -F'
alias ll='ls -lF'
alias la='ls -a'
alias vi=/usr/local/bin/vim
alias vim=/usr/local/bin/vim

# Functions

mcd() {
    mkdir -p $1
    cd $1
}

awslogin() {
    cwd=`pwd`
    cd $OKTA_AWS_HOME
    ./awscli.command
    cd $cwd
}

g() {
    ./gradlew "$@"
}

_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}

_prompt_command() {
    local BRANCH=`_git_branch`
    local LOAD=`uptime|awk '{min=NF-2;print $min}'`
    local TIME='\t'
    local NEWLINE='\n'

    local GREEN="\[\033[0;32m\]"
    local CYAN="\[\033[0;36m\]"
    local BCYAN="\[\033[1;36m\]"
    local BLUE="\[\033[0;34m\]"
    local GRAY="\[\033[0;37m\]"
    local DKGRAY="\[\033[1;30m\]"
    local WHITE="\[\033[1;37m\]"
    local RED="\[\033[0;31m\]"

    # return color to Terminal setting for text color
    local DEFAULT="\[\033[0;39m\]"
    export PS1="\n[\!] \t ${RED}(${LOAD}) ${GREEN}\w\n${CYAN}${BRANCH}${DEFAULT}\$ "   
}

PROMPT_COMMAND=_prompt_command
