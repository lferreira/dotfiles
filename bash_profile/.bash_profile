#!/bin/bash
if [ -s ~/.bashrc ]; then source ~/.bashrc; fi

source ~/.gvm/scripts/gvm
source ~/.exports
source ~/.env-golang
source ~/.alias
source ~/.extras

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

eval "$(direnv hook zsh)"

eval "$(/opt/homebrew/bin/brew shellenv)"
<<<<<<< HEAD:bash_profile/.bash_profile
eval "$(atuin init zsh)"
=======

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
>>>>>>> 18a4c81 (sync envs):.bash_profile
