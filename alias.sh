#Handy aliases
alias lg='ls -Ago --group-directories-first'
alias ll='ls -Alo --group-directories-first'
alias echo='gecho'
alias desk='cd ~/Desktop/'
alias docu='cd ~/Documents/'
alias dwn='cd ~/Downloads/'
alias refrash='source ~/.profile'
alias ls='gls -Fh --color'
alias npmi='(npm install &> npm.log && terminal-notifier -title "npm" -message "Install has finished!" -sound default) || terminal-notifier -title "npm" -message "Install has failed" -sound default'
alias cppath='pwd|pbcopy'
alias grep='ggrep --color'
alias c='clear'
alias cls="echo -en '\033c\033[3J'"
alias crontab='VIM_CRONTAB=true crontab'
alias gc='git clone'
alias mdtw='mvnDebug -T 1C tomcat7:run-war'
alias mdjw='mvnDebug jetty:run-war'
alias mdt='mvnDebug -T 1C tomcat7:run'
alias mdj='mvnDebug jetty:run'
alias glsau='git ls-files -v | grep -e "^[hsmrck]"'
alias mtom='mvn -T 1C tomcat7:run-war'
alias mjet='mvn jetty:run-war'
alias mci='mvn clean install'
alias mcid='mvn -T 1C clean install -DskipTests'
alias bash4='/usr/local/Cellar/bash/4.4/bin/bash -l'
alias ip='ipconfig getifaddr en0'

function l(){
    gls -1AhFs $1 --color=always --group-directories-first | awk '{print $2}';
}

#Handy bindings
bind '"\e[24~":"cls\n"' # maps f12 to cls
