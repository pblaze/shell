export GREP_OPTIONS='--color=auto --exclude=*.class --exclude-dir=target'
export GIT_EDITOR=vim

# Mac Os Specific (Maybe) - this will work when we've upgraded to java 9
# export JAVA_HOME=$(/usr/libexec/java_home)

# Force Java 1.8 as JAVA_HOME
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home
export PATH=${PATH}:${JAVA_HOME}

export PS1="[\[\033[00m\]\u@\h\[\033[32m\] \W \$(parse_git_branch)\[\033[00m\]]$\[\033[00m\] "
export PATH=/usr/local/bin:$PATH

alias s='git status'
# ignore whitespace: alias d='git diff -w HEAD'
alias d='git diff HEAD'
alias comp='python ~/py_test_compile.py'
alias ll='ls -lrt'
alias fir='git'

# remove alias
alias dockerstp=‘docker stop $(docker ps -a -q)’
alias dockerrmv=‘docker rm $(docker ps -a -q)’

# vi commands in terminal
set -o vi

function get() {
    git log -"$1" | sed "s/commit /https:\/\/github\.com\/ORG_NAME\/$(parse_git_branch)\/commit\//" | sed 's/\(.*commit.*\)$/\1/'
}

# setup a virtualenv
function ve() {                                                                 
    virtualenv "$1"                                                             
    source "$1/bin/activate"                                                    
}

# pbcopy is osx specific
function gh() {
    git log -"$1" | grep 'commit' | sed "s/commit /https:\/\/github\.com\/ORG_NAME\/$(parse_git_repo)\/commit\//" | sed 's/\(.*commit.*\)$/\1\?w=1/' | pbcopy
    git log -"$1" | sed "s/commit /https:\/\/github\.com\/ORG_NAME\/$(parse_git_repo)\/commit\//" | sed 's/\(.*commit.*\)$/\1\?w=1/'
}

parse_git_repo() {
    git config --get remote.origin.url | sed 's/https:\/\/github.com\/ORG_NAME\/\(.*\)\.git/\1/'
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function scp_machine {
    rsync -rlpt -e "ssh -A bastione1 ssh -A" --delete $1 machine:$2
}
