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
export VAULT_AUTH_GITHUB_TOKEN=$(security find-generic-password -a "${USER}" -s "FT Vault" -w)
export COMPOSER_AUTH_GITHUB_TOKEN=$(security find-generic-password -a "${USER}" -s "FT Composer" -w)

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