
export GITHUB_USERNAME="LiveGood"
export BASE_EMAIL="FleshThps@gmail.com"
export TEMPFILE=/home/deyan/Documents/temp/.bash_temp.txt

# Restarts the bashrc file to update changes 
alias rb="source ~/.bashrc"
# Restarts the entile shell
alias eb="exec bash"
alias c=clear
alias rf="rm -rf"
alias xclip="xclip -selection c"

# Programs run from Windows
alias chrome="/mnt/c/'Program Files'/Google/Chrome/Application/chrome.exe"

# Yarn alliases
alias t="clear && yarn test"
alias to="clear && yarn test:only"
alias yi="yarn install"
alias ya="yarn add"
alias yar="yarn remove"
alias yb="yarn build"
alias ytc="yarn test:cover"
alias ytu="yarn test:update"
alias yg="yarn gen"
alias r="yarn dev"

# Git alliases
alias gp="git push"
alias gpu="git pull"
alias ga="git add ."
alias gb="git branch"
alias gcm="git commit -m"
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

# git log
alias gl="git log"

# git stash
alias gst="git stash"
alias gsc="git stash clear"
alias gsm="git stash push -m"
alias gsp="git stash pop"
alias gsa="git stash apply"
alias gsd="git stash drop"
alias gsl="git stash list"

alias gf="git fetch --all"
# convert line endings, just to remind myself how to
# dos2unix .sh .bash 
