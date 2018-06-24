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

setUpKaamelottOtter() {
    local misc_path=$HOME/misc
    mkdir -p $misc_path
    if [ ! -f $HOME/misc/otter.cow ]; then wget -qP $misc_path 'https://gist.githubusercontent.com/thcdrt/2022e0ccee7092f8839c0071575d5dd7/raw/8ddbde2ea4e4e0c9e4c250f3c2733d35f7822cd6/otter.cow'; fi
    if [ ! -f $HOME/misc/kaamelott_quotes.json ]; then wget -qP $misc_path 'https://gist.githubusercontent.com/thcdrt/6c281882f71a96e413d2d5171bc60cb1/raw/53f0796de232d17ae0eb49cb5e4e33137a500af0/kaamelott_quotes.json'; fi
}

# Display an otter quoting a random famous Kaamelott character. Call setUpKaamelottOtter() once first.
shuf -n1 $HOME/misc/kaamelott_quotes.json | cowsay -f $HOME/misc/otter.cow | lolcat

# Source some personal alias
[ -f ~/.myalias ] && source ~/.myalias
