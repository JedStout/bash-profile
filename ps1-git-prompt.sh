# PS1 git prompt
# curl -o ./git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

Color_Off="\[\e[0m\]"       # Text Reset

# Regular Colors
Black="\[\e[0;30m\]"        # Black
Red="\[\e[0;31m\]"          # Red
Green="\[\e[0;32m\]"        # Green
Yellow="\[\e[0;33m\]"       # Yellow
Blue="\[\e[0;34m\]"         # Blue
Purple="\[\e[0;35m\]"       # Purple
Cyan="\[\e[0;36m\]"         # Cyan
White="\[\e[0;37m\]"        # White

# Bold
BBlack="\[\e[1;30m\]"       # Black
BRed="\[\e[1;31m\]"         # Red
BGreen="\[\e[1;32m\]"       # Green
BYellow="\[\e[1;33m\]"      # Yellow
BBlue="\[\e[1;34m\]"        # Blue
BPurple="\[\e[1;35m\]"      # Purple
BCyan="\[\e[1;36m\]"        # Cyan
BWhite="\[\e[1;37m\]"       # White

# Underline
UBlack="\[\e[4;30m\]"       # Black
URed="\[\e[4;31m\]"         # Red
UGreen="\[\e[4;32m\]"       # Green
UYellow="\[\e[4;33m\]"      # Yellow
UBlue="\[\e[4;34m\]"        # Blue
UPurple="\[\e[4;35m\]"      # Purple
UCyan="\[\e[4;36m\]"        # Cyan
UWhite="\[\e[4;37m\]"       # White

# Background
On_Black="\[\e[40m\]"       # Black
On_Red="\[\e[41m\]"         # Red
On_Green="\[\e[42m\]"       # Green
On_Yellow="\[\e[43m\]"      # Yellow
On_Blue="\[\e[44m\]"        # Blue
On_Purple="\[\e[45m\]"      # Purple
On_Cyan="\[\e[46m\]"        # Cyan
On_White="\[\e[47m\]"       # White

# High Intensty
IBlack="\[\e[0;90m\]"       # Black
IRed="\[\e[0;91m\]"         # Red
IGreen="\[\e[0;92m\]"       # Green
IYellow="\[\e[0;93m\]"      # Yellow
IBlue="\[\e[0;94m\]"        # Blue
IPurple="\[\e[0;95m\]"      # Purple
ICyan="\[\e[0;96m\]"        # Cyan
IWhite="\[\e[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\e[1;90m\]"      # Black
BIRed="\[\e[1;91m\]"        # Red
BIGreen="\[\e[1;92m\]"      # Green
BIYellow="\[\e[1;93m\]"     # Yellow
BIBlue="\[\e[1;94m\]"       # Blue
BIPurple="\[\e[1;95m\]"     # Purple
BICyan="\[\e[1;96m\]"       # Cyan
BIWhite="\[\e[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\e[0;100m\]"   # Black
On_IRed="\[\e[0;101m\]"     # Red
On_IGreen="\[\e[0;102m\]"   # Green
On_IYellow="\[\e[0;103m\]"  # Yellow
On_IBlue="\[\e[0;104m\]"    # Blue
On_IPurple="\[\e[10;95m\]"  # Purple
On_ICyan="\[\e[0;106m\]"    # Cyan
On_IWhite="\[\e[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"
space=" "
#topElbow="┌ "
#btmElbow="└ "
crown="👑 "
skull="☠ "
christmasTree="🎄 "
thumbsUp="👍 "
thumbsDown="👎 "
moneyBag="💰 "
poop="💩 "
beerMug="🍺 "
fire="🔥 "
oneHundred="💯 "
normalPrompt="$"
# alt elbows ┌• └• ╔ ■ ╚ ■

# git prompt
source ~/bash-profile/git-completion.sh
source ~/bash-profile/git-prompt.sh
source ~/bash-profile/svn-prompt.sh

function isPatched(){
    if [[ $BASH_VERSION == "4.3.42(1)-release" ]]; then
        echo "\m"
    fi
}

function gitStatus() {
    # git-ps1 config vars
    GIT_PS1_SHOWDIRTYSTATE=1;
    GIT_PS1_SHOWSTASHSTATE=1;
    GIT_PS1_SHOWUNTRACKEDFILES=1;
    #GIT_PS1_SHOWUPSTREAM="";
    #GIT_PS1_STATESEPARATOR=" ";

    # simple branch name current_branch=$(git branch | egrep -i '^\* .*' | cut -c 3-);
    local git_ps1='';
    if git status | grep -q "nothing to commit"; then
        if git status | grep -q "ahead of"; then
            num_ahead=$(git status | egrep -o '[0-9]+');
            git_ps1=$BBlue$(__git_ps1 "(%s")" < "$num_ahead")";
        else
            git_ps1=$Blue$(__git_ps1 "(%s)");
        fi
    elif git status | grep -q "Changes to be committed"; then
        if git status | grep -q "Changes not staged for commit"; then
            git_ps1=$BPurple$(__git_ps1 "{%s}");
        else
            git_ps1=$Purple$(__git_ps1 "[%s]");
        fi
    else
        git_ps1=$Red$(__git_ps1 "{%s}");
    fi
    echo $git_ps1$Color_Off
}

function svnStatus() {
    local svn_ps1=$Blue$(__git_svn_ps1);
    if [[ $(svn st) ]]; then
        svn_ps1=$Red$(__git_svn_ps1);
    fi
    echo $svn_ps1$Color_Off
}

function gitPS1() {
    if [[  $(git branch &>/dev/null; echo $?) -eq 0 ]]; then
        echo "$Color_Off$(gitStatus)$space$BYellow"
    elif [[ $(svn info &>/dev/null; echo $?) -eq 0 ]]; then
        echo "$Blue$(svnStatus)$space$BYellow"
    fi
}

function truncatePath() {
    local curpath=`pwd | sed 's,'$HOME',~,'`
    local depth=`grep -o '/' <<<"$curpath" | grep -c .`
    local TruncPath=''
    if [[ $depth -gt $1 ]]; then
        # curpath=${curpath:-30}
        curpath=`pwd | egrep -o '/[^/]+/[^/]+/[^/]+$'`
        TruncPath=$(echo -n "$curpath/" | sed 's,^[^/]*,...,');
    else
        if [ "$curpath" == "~" ] || [ "$curpath" == "/" ]; then
            TruncPath=$curpath;
        else
            TruncPath=$curpath"/";
        fi
    fi
    echo $TruncPath;
}

function getHostEnv() {
     local hostEnv=`cat /etc/hosts | grep -Po '(?<=env:).+'`
     if [[ ${#hostEnv} > 0 ]];then
         echo $hostEnv$space$Color_Off
     else
         echo $Time12h$space$Color_Off
     fi
 }

function myprompt() {
    local promptEnd=$normalPrompt
    if [[ $CATHODE == 1 ]]; then
        promptEnd=$normalPrompt
    fi
    PS1=$Green$(getHostEnv)$Yellow$(gitPS1)$(truncatePath 3)$NewLine$IBlack$(isPatched)$BIBlack$promptEnd$Color_Off$space
}

# command to run in cathode terminal

export PROMPT_COMMAND=myprompt
export PS2=$IBlack$btmElbow$Mode$IBlack">"$space$Color_Off
