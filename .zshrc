# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# CFR

if [[ `uname` == 'Linux' ]]; then export OS=Linux; fi
if [[ `uname` == 'Darwin' ]]; then export OS=OSX; fi

BREW="1"
[ -f ~/homebrew_github_api_token ] && source ~/homebrew_github_api_token
PAGER="less"
HOSTNAME=$(hostname)
TERM="xterm-color"
EDITOR="vim"

alias man='LC_ALL=C LANG=C man'
alias ls="ls -G"
alias =clear
alias L=clear
alias vi=vim
# Midnight Commander
alias mc='mc -S nicedark'
# Recursive fast operation
function recurse() {
  if [ "$#" -lt 3 ]; then
      echo "Syntax: recurse dir1 dir2 commandline...";
  else
      dir1="$1"
      shift
      dir2="$1"
      shift
      find $dir1 -type f -exec $@  {} $dir2/{} \;
  fi
}
# Ansible
function aplay() {
  hosts="$1"
  shift
  ansible-playbook -i ~/.ansible/hosts /Users/Chris/bin/playbooks/${hosts}.yml $@
}
function oplay() {
  hosts="$1"
  shift
  ansible-playbook -i ~/.ansible/hosts ${hosts}.yml $@
}
function lplay() {
  wh="$1"
  ls /Users/Chris/bin/playbooks/${wh}
}
# Puppet
function start_puppet() {
dinghy start && docker start puppet && nohup socat -d -d TCP-LISTEN:8140,reuseaddr,fork,bind=192.168.1.20 tcp:$(dinghy ip):8140 &
}

# Path
if [[ "$OS" == "OSX" ]]; then
    export PATH="/Users/Chris/bin/osx"
else
    export PATH="~/bin/linux"
fi
export PATH="$PATH:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/local/git/bin:/usr/X11/bin"
# Node Path
export PATH=$HOME/local/node/bin:$PATH
# Android Dev Path
export PATH=$HOME/Projects/android-sdk-macosx/platform-tools:$HOME/Projects/android-sdk-macosx/tools:$HOME/Projects/android-sdk-macosx/tools/proguard/bin:$HOME/Projects/android-ndk-r10d:$PATH
# Scala Path
export PATH="/Users/Chris/scala/bin:${PATH}"
# Ruby Path
export PATH="/opt/bin:$HOME/.rbenv/bin:$HOME/.rbenv/versions/1.9.3-p194/bin:$PATH"

# Node Specific
export NODE_PATH=/usr/local/lib/node:$NODE_PATH
# Android Specific
export ANDROID_HOME=/Users/Chris/Projects/android-sdk-macosx
# Scala Specific
export SCALA_HOME=$HOME/scala
# Ruby Specific
which rbenv &>/dev/null && eval "$(rbenv init -)"
# Java Specific
[ -f /usr/libexec/java_home ] && export JAVA_HOME=$(/usr/libexec/java_home)
alias setjava7='export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home" && PATH=$JAVA_HOME/bin:$PATH'
# Rust Specific
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

# Go Specific
export GOPATH=/Users/Chris/go
export PATH=$GOPATH/bin:$PATH

# My Macros
[ -f /Users/Chris/bin/source/mymacros ] && source /Users/Chris/bin/source/mymacros

# Zplug
export ZPLUG_HOME=/usr/local/opt/zplug
if [[ -s "$ZPLUG_HOME/init.zsh" ]]; then
    source $ZPLUG_HOME/init.zsh
    zplug "supercrabtree/k"
    zplug install
    zplug load
fi

# TMUX Logging alias
alias tl='~/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh'

# Dinghy (Docker Machine)
[ -f /usr/local/bin/dinghy ] && eval $(dinghy env)

# Taskwarior
export TASKDDATA=/Users/Chris/.taskdata

# fzf
# (Installed shell extensions using: /usr/local/opt/fzf/install)
# Upgrade: `brew update; brew reinstall fzf` vim: `:PlugUpdate fzf`

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# direnv
which direnv &>/dev/null && eval "$(direnv hook zsh)"

# ask Linux if command not found
command_not_found_handler() {
    docker exec -it ubuntu "$@"
}

ub() {
    echo "$@"
    docker exec -it ubuntu "$@"
}

kde-common() {
    if [ $(ps -x | grep 'XQuartz.app' | grep -v grep | wc -l) -lt 1 ]; then
        open -a XQuartz
    fi
    if [ $(ps -x | grep socat | grep 'TCP-LISTEN:6000' | wc -l) -lt 1 ]; then
        socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:/tmp/x11_display &
    fi
    if [ $(docker ps | grep kde-env | wc -l) -lt 1 ]; then
        if [ $(docker images | grep kde-env | wc -l) -lt 1 ]; then
            docker run -it --cap-add=SYS_ADMIN -e DISPLAY=$(ipconfig getifaddr en0):0.0 -v /Users/Chris:/Users/Chris --name kde-env kdeneon/plasma:dev-unstable bash
        fi
        docker start kde-env
    fi
}

kde() {
    kde-common
    if [ $# -lt 1 ]; then
        echo -e "For instance:\ndolphin -- file manager\nkgraphviewer -- view graphviz files\numbrello -- UML modeller\nkleopatra -- gpg cert manager\nokular -- universal document viewer\ngwenview -- image viewer"
    else
        docker exec -d kde-env "$@"
    fi
}

kdessh() {
    kde-common
    docker exec -it kde-env "$@"
}

. ~/welcome

###-tns-completion-start-###
#if [ -f /Users/Chris/.tnsrc ]; then 
#    source /Users/Chris/.tnsrc 
#fi
###-tns-completion-end-###
