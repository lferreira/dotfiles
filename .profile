source ~/.env-golang
source ~/.exports

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s "/Users/luiz.ferreira/.gvm/scripts/gvm" ]] && source "/Users/luiz.ferreira/.gvm/scripts/gvm"
