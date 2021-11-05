
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
#################################################

# git merge
alias gmd="git merge develop"

#git commit 
cmn() {
    if [ $# -gt 1 ]; then
        argsString="$*"
        git commit -m ''"$argsString" --no-verify
    else
        git commit -m $1 --no-verify
    fi
}

cm() {
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

gspu() {
    if [ $# -gt 1 ]; then
        argsString="$*"
        git stash push -m ''"$argsString"
    else
        git stash push -m $1
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

gbda() {
    local branchName=$1
    git branch -D $branchName && echo "Deleting remote branch $branchName"  && git push origin --delete $branchName
}
