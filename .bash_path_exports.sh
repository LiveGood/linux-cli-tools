
# NVM PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# DENO PATH
export DENO_INSTALL="/home/deyan/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
