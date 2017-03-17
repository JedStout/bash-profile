export JAVA_HOME=$(/usr/libexec/java_home)
export JDK_HOME=$(/usr/libexec/java_home)
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/bin/npm:$PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=/opt/subversion/bin/:$PATH
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
#Handy vars
desk="/Users/jstout/Desktop"
downloads="/Users/jstout/Downloads"
docu="/Users/jstout/Documents"
set -o vi
stty -ixon # disble flow control to free up precious C-s and C-q shortcuts
