#!/bin/sh

echo "Installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing wget"
brew install wget

echo "Installing Docker 3.3.3"
wget https://desktop.docker.com/mac/stable/amd64/64133/Docker.dmg -p ~/Downloads 
sudo hdiutil attach ~/Downloads/Docker.dmg
cp -rf "/Volumes/Docker 2/Docker.app" /Applications
sudo hdiutil unmount /Volumes/Docker\ 2

echo "Installing nvm"
brew install nvm 
mkdir ~/.nvm 

echo "Installing platform.sh"
curl -fsS https://platform.sh/cli/installer | php

echo "Installing Vault"
brew tap hashicorp/tap
brew install hashicorp/tap/vault

echo "Installing Heroku"
brew tap heroku/brew && brew install heroku

echo "Installing lastpass-cli"
brew install lastpass-cli

echo "Installing Visual Studio Code"
brew install --cask visual-studio-code

echo "Install GIT credential manager"
brew tap microsoft/git
brew install --cask git-credential-manager-core

cat <<'EOF' >>~/.zshrc

# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

echo "Installing VSCode Extensions"
code --install-extension blanu.vscode-styled-jsx
code --install-extension chris-noring.node-snippets
code --install-extension christian-kohler.path-intellisense
code --install-extension cweijan.vscode-mysql-client2
code --install-extension eamodio.gitlens
code --install-extension GraphQL.vscode-graphql
code --install-extension hashicorp.terraform
code --install-extension whatwedo.twig
code --install-extension davidanson.vscode-markdownlint

echo "Installing VirtualBox" # Requires password
brew install --cask virtualbox

echo "Installing Brave Browser"
brew install --cask brave-browser

echo "Adding variables to .zshrc"
cat <<'EOF' >>~/.zshrc

alias c="clear"
alias rb="exec $SHELL"
alias rf="rm -rf"
alias mb="du -sh"
alias ctok="echo $VAULT_AUTH_GITHUB_TOKEN | pbcopy; open https://vault.in.ft.com:8080/; echo 'Copied GitHub token into clipboard.'"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias brave='open -a "Brave Browser.app"'
alias path='echo "${PATH//:/\n}"'

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
# Set the Vault cluster address.
export VAULT_ADDR=https://vault.in.ft.com

# Set the personal access token to use for authentication with Vault.
#  security add-generic-password -a "$USER" -s "FT Composer" -w "<github-personal-access-token>"
export COMPOSER_AUTH_GITHUB_TOKEN=$(security find-generic-password -a "${USER}" -s "FT Composer" -w)

export VAULT_AUTH_GITHUB_TOKEN=$(security find-generic-password -a "${USER}" -s "FT Vault" -w)
export COMPOSER_AUTH_GITHUB_TOKEN=$(security find-generic-password -a "${USER}" -s "FT Composer" -w)

function add_secret() {
  if [[ $# != 2 ]]; then 
    echo "add_secret requires 2 arguments: <secret-name> <secret>"
    exit 1;
  fi

  name=$1
  password=$2
  security add-generic-password -a "$USER" -s "$name" -w "$password"
}

function get_secret() {
    if [[ $# != 1 ]]; then 
    echo "add_secret requires 1: <secret-name> "
    exit 1;
  fi

  name=$1
  security find-generic-password -a "${USER}" -s "$name" -w | pbcopy 
}

function regen_token() {
  new_token=$1
  # security add-generic-password -a "$USER" -s "FT Vault" -w "$new_token"
  export VAULT_AUTH_GITHUB_TOKEN=$(security find-generic-password -a "${USER}" -s "FT Vault" -w)
}

# Prevent `vault write` commands from being stored in history.
function vault () {
  command vault "$@"
  if [[ $1 == write ]]; then 
    history -d $((HISTCMD-1)) &> /dev/null;
  elif [[ $1 == log ]]; then
    vault login --method=github token=$VAULT_AUTH_GITHUB_TOKEN
  fi
}

# BEGIN SNIPPET: Platform.sh CLI configuration
HOME=${HOME:-'/Users/deyan.dachev'}
if [ -f "$HOME/"'.platformsh/shell-config.rc' ]; then . "$HOME/"'.platformsh/shell-config.rc'; fi # END SNIPPET

function opn() {
  if [[ $1 == "commands" ]]; then
    chrome https://stackoverflow.com/a/58966776
  fi
}

EOF

cat <<'EOF' >>~/credentials2.json
lpass show --notes "eZ Auth" | python2 -c '
import os, sys, json;
stdinJson = json.load(sys.stdin);
stdinJson["github-oauth"] = {
  "github.com": os.environ["COMPOSER_AUTH_GITHUB_TOKEN"]
};
authFile = open("auth.json", "w")
authFile.write(json.dumps(stdinJson, indent=2))
authFile.close()'
EOF