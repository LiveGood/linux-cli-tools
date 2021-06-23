
# Git alliases
alias gp="git push"
alias gpu="git pull"
alias ga="git add ."
alias grh1="git reset HEAD~1"
alias grh2="git reset HEAD~2"
alias grh3="git reset HEAD~3"
alias gd="git diff"
alias gs="git status"
alias grh="git reset --hard"

# git checkout
alias gc="git checkout"
alias gcd="git checkout develop"
alias gcb="git checkout -b"
alias gcdp="git checkout develop && git pull"
alias gcmp="git checkout main && git pull"

# git log
alias gl="git log"

# git stash
alias gst="git stash"
alias gsc="git stash clear"
alias gsm="git stash push -m"
alias gsp="git stash pop"
# alias gsa="git stash apply"
# alias gsd="git stash drop"
alias gsl="git stash list"

alias gf="git fetch --all"

# git branch
alias gb="git branch"
alias gbrn="git branch -m "
#################################################

#git commit 
gcmn() {
    git commit -m $1 --no-verify
}

gcm() {
    if [ $# -gt 1 ]; then
        argsString="$*"
        git commit -m ''"$argsString"
    else
        git commit -m $1
    fi
}
#################################################

# git push all current chagnes
gpush() {
    git add . 
    if [ $# -gt 1 ]; then
        argsString="$*"
        git commit -m ''"$argsString"
    else
        git commit -m $1
    fi
    git push
}
#################################################

# git stash
gsd() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        git stash drop stash@{$1}
    else
        git stash drop
    fi
}

gsa() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        git stash apply stash@{$1}
    else
        git stash apply
    fi
}
#################################################

# 1. stash changes form current branch
# 2. go to develop and pull
# 3. go to previous branch and merge from develop
# 4. unstash previous changes
gcdb() {
    local branchName=$(git rev-parse --abbrev-ref HEAD)
    git add .
    git stash
    git checkout develop && git pull
    git checkout ''"$branchName"
    git merge develop
    git stash apply && git reset . && git stash drop
}
