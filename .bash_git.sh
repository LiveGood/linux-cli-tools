
# Git alliases

alias gp="git push"
alias gpu="git pull"
alias ga="git add ."
alias gd="git diff"
alias gs="git status"

# git reset
alias grh1="git reset HEAD~1"
alias grh2="git reset HEAD~2"
alias grh3="git reset HEAD~3"
alias grh="git reset --hard"
alias grs="git reset --soft"

# git fetch
alias gfa="git fetch --all"

# git checkout
alias gc="git checkout"
alias gcd="git checkout develop"
alias gcm="git checkout main"
alias gcb="git checkout -b"
alias gcdp="git checkout develop && git pull"

# git log
alias gl="git log"

# git stash
alias gst="git stash"
alias gsc="git stash clear"
alias gspm="git stash push --message"
alias gsp="git stash pop"
alias gsl="git stash list"

# git branch
alias gb="git branch"
alias gbrn="git branch -m "
alias gbd="git branch -D"
alias gbdo="git push origin --delete"
alias gbc="git branch --show-current"
#################################################

# git merge
alias gmd="git merge develop"

local argsString=''
# Alllows all the other git alias functions to receive messages without the need to add single or double quotes
# Example:
# cm New commit message ---> git commit -m 'New commit message'
setArgsString() {
    if [ $# -gt 1 ]; then
        argsString="$*"
    else
        argsString="$1"
    fi
}

# git commit
cm() {
    setArgsString $*
    git commit -m "$argsString"
}

#git commit with add all current changes
cma() {
    setArgsString $*
    git commit --all -m "$argsString"
}

# git commit with no precommit hooks executed
cmn() {
    setArgsString $*
    git commit -m "$argsString" --no-verify
}

#################################################

# git add, commit and push together
gpush() {
    setArgsString $*
    git commit -am "$argsString"
    # References to the allias on line 3
    gp
}

# git stash drop
gsdr() {
    if [[ $1 =~ "^[0-9]+$" ]]; then
        git stash drop stash@{$1}
    else
        git stash drop
    fi
}

# git stash apply
gsa() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        git stash apply stash@{$1}
    else
        git stash apply
    fi
}

# git stash push -m
gspu() {
    setArgsString $*
    git stash push -m "$argsString"
}
#################################################

# 1. stash changes form current branch
# 2. go to develop and pull
# 3. go to previous branch and merge from develop
# 4. unstash previous changes
gcdb() {
    local branchName=$(git branch --show-current)
    git add .
    git stash
    git checkout develop && git pull
    git checkout ''"$branchName"
    git merge develop
    git stash apply && git reset . && git stash drop
}

# Delete delete remote branch
# gbda() {
#     local branchName=$1
#     git branch -D $branchName && echo "Deleting remote branch $branchName"  && git push origin --delete $branchName
# }
