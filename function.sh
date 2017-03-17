#Handy functions

function vimp() {
    local editor=vim;
    local fileName=.;
    if [[ $# > 1 ]]; then
        if [[ $1 == '-m' ]]; then
            editor=mvim;
            fileName=$2;
        elif [[ $2 == '-m' ]]; then
            editor=mvim;
            fileName=$1;
        fi
    elif [[ $# > 0 && $1 != '-m' ]]; then
        fileName=$1;
    elif [[ $1 == '-m' ]]; then
        editor=mvim;
    fi
    cd ~/bash-profile/
    $editor $fileName;
}

function subl() {
	sublime $1
}

function wrapnpm() {
    if [[ ( $1 == 'install' || $1 == 'i' ) && -e ./.nvmrc ]]; then
        if [[ $(nvm use &>/dev/null; echo $?) == 0 ]]; then
            nvm use;
            npm $@;
        else
            nvm use;
        fi
    else
        npm $@;
    fi
}

function up(){ DEEP=$1; [ -z "${DEEP}" ] && { DEEP=1; }; for i in $(seq 1 ${DEEP}); do cd ../; done; }

function finder() {
	open -a "finder" $1
}

function cpclip() {
    cat $1 | pbcopy
}

function close() {
if [[ $# -eq 1 ]]; then
	echo closing $1...
	osascript -e 'quit app "'"$1"\"
else
	echo incorrect number of arguments
fi
}

function sedi() {
		sed -i '' 's/'$1'/'2'/g' $3
}

function mxc() {

    if [[ ! -d "/Volumes/mxc" ]]; then
			osascript -e 'tell app "Finder" to open location "cifs://overstock.com/files/www/images/mxc"'
			echo "connecting to server..."
			# read -rsp $'Once mxc has opened press any key to continue...\n' -n1 key
			while [[ ! -d "/Volumes/mxc" || !  "$(ls -A /Volumes/mxc)" ]]
			do
				sleep 1s
			done
		fi

    if [[ "$#" -eq 1 ]]; then
			cp $1 /Volumes/mxc/
    elif [[ "$#" -gt 1 ]]; then
      imagesArray=( "$@" )

      for i in "${imagesArray[@]}"
      do
         cp $i /Volumes/mxc/
      done
    fi
}

function npmin(){
whileCond=true;
for arg in $@
do
    if [[ $arg -eq "--save-dev" || $arg -eq "--save" ]]; then
        npm install $#; break;
    fi
    if [[ ${arg:0:1} != "-" ]]; then
        package=$arg;
    fi
    echo $arg;
done
while $whileCond; do
    read -p "do you want to save this? " yn
    case $yn in
        [Yy]* ) npm install $package --save-dev; whileCond=false;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
}

# shopping site patch shortcut
function svnpatch () {
    svn diff -r$1:$2 . > ~/$3.patch;
}

# function to change directory to the one set in the last opened finder.
function cdf () {
    finderPath=`osascript -e 'tell application "Finder"
                                try
                                    set currentFolder to (folder of the front window as alias)
                                on error
                                    set currentFolder to (path to desktop folder as alias)
                                end try
                                POSIX path of currentFolder
                            end tell'`;
	echo "cd to \"$finderPath\""
	cd "$finderPath"
}

function mkcd() { mkdir $1 ; cd $1 ; }

function ws() {
if [[ $# -eq 0 ]]; then
	echo Launching PHP webserver...
	php -S 127.0.0.1:8080 -t public/
	echo Exiting PHP webserver...
elif [[ $# -eq 1 ]]; then
	echo Launching PHP webserver...
	php -S 127.0.0.1:$1 -t public/
	echo Exiting PHP webserver...
elif [[ $# -eq 2 ]]; then
	if [[ $1 == '-t' ]]; then
		echo Launching PHP webserver...
		php -S 127.0.0.1:8080 -t $2
		echo Exiting PHP webserver...
	else
		echo Launching PHP webserver...
		php -S 127.0.0.1:$1 -t $2
		echo Exiting PHP webserver...
	fi
else
	echo Imporper number of arguments
fi
}

function mktemp(){
    if [[ $# -eq 2 ]]; then
        cat ~/bash-profile/.templates/template-$1 > $2 ;
        else
            echo "invalid arguments";
    fi
}

function mkproj() {
if [[ $# -eq 1 ]]; then
	mkdir css ;
	mkdir js ;
	mkdir templates;
	touch css/style.css ;
	touch js/main.js ;
	touch index.html ;
	cat ~/bash-profile/.templates/template-$1 > index.html ;
elif [[ $# -eq 2 ]]; then
	mkcd $2 ;
	mkdir css ;
	mkdir js ;
	touch css/style.css ;
	touch js/main.js ;
    cat ~/bash-profile/.templates/template-$1 > index.html ;
fi
}

#gitignore.io util
function gi() {
	if [[ $# -eq 1 ]]; then
		curl -L -s https://www.gitignore.io/api/$@ ;
	else
		curl -L -s https://www.gitignore.io/api/$1 >> $2 ;
		echo $2 generated.
	fi
}

# toggle dot file visibility
function dot() {
    if [[ $# == 1 && ( $1 == YES || $1 == NO || $1 == yes || $1 == no ) ]]; then
        defaults write com.apple.finder AppleShowAllFiles $1;
        killall Finder /System/Library/CoreServices/Finder.app;
    fi
}

# zip -r helper
function zipr() {
    if [[ -d $1 ]]; then
        zip -r $1'.zip' $1;
    else
        echo "invalid arguments"
    fi
}
