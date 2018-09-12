[ -n "$PS1" ] && source ~/.bash_profile;

source ~/.base16-shell/scripts/base16-solarized-dark.sh

if [ -s ~/.env-golang ]; then
  source ~/.env-golang
fi
