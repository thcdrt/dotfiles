# ZSH configuration
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"

plugins=(git git-extras git-flow colored-man-pages colorize cp screen tmux ssh-agent go knife)
source $ZSH/oh-my-zsh.sh

COMPLETION_WAITING_DOTS="true"

# Alias
alias a='ansible'
alias ap='ansible-playbook'
alias c='clear'
alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'
alias e='echo'
alias g='git'
alias h='history'
alias m='make'
alias node="nodejs"
alias s='ssh'
alias tf='terraform'
alias tm="tmux"

# Docker aliases
dps(){
    docker ps -a --format 'table{{.Names}}\t{{.Status}}'
}

dstopall() {
    docker stop $(docker ps -a -q)
}

dkillall() {
    docker rm -f $(docker ps -a -q)
}

dim () {
    docker images | grep $@
}

# Functions
randpwd(){
    local length=${1:-42}
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $length | head -1
}

sourcenv () {
        if [[ "$1" != "" ]]
        then
                export $(cat $1 | xargs)
        else
                while read envfile
                do
                        echo "source $envfile"
                        export $(cat $envfile | xargs)
                done < <(find . -name "*.env")
        fi
}

# Source some personal alias
[ -f ~/.myalias ] && source ~/.myalias