
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
alias yl="yarn lint"
alias r="yarn dev"

# convert line endings, just to remind myself how to
# dos2unix .sh .bash 
