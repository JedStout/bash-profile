#node version manager
source ~/.nvm/nvm.sh

#my profile
source ~/bash-profile/myprofile.sh

#Handy aliases
source ~/bash-profile/alias.sh

#Handy functions
source ~/bash-profile/function.sh

#PS1 git prompt
source ~/bash-profile/ps1-git-prompt.sh

#coreutils path var
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=$PATH:$HOME/.yarn/bin

#pyenv init
eval "$(pyenv init -)"
