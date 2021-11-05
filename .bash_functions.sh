
projectsDir="/home/deyan/dev-projects"

# Efficent function to start all the diffrent projects
start() {
    if [ "$1" = "ytapp" ]; then
        code "$projectsDir/practice-projects/youtube-app"
    elif [ "$1" = "timers" ]; then
        chrome "" --new-window https://duckduckgo.com/?q=timer
        copy -f /home/deyan//Documents/html-scripts/duck-duck-timers.js
    else 
        echo "start doesn't have option: $1"
    fi
}

copy() {
    if [ "$1" = "-f" ] || [ "$1" = "--file" ]; then
        content=$(cat $2)
    else 
        content=$1
    fi

    echo -n $content | utf8clip.exe | powershell.exe -noprofile -command Get-Clipboard
}

# prints the running processes based on a greped string, it would match names or PIDs
# -l argument prints the long template of processes stogether with C    SZ   RSS PSR STIM
# -s argument prints the short template of processes such as PID TTY PROCess
logps() {
	local psArg=''
	local grepArg=''

    if [ "$1" = "-a" ]; then
        psArg='-eF'
        grepArg=$2
    elif [ "$1" = "-s" ]; then
    	psArg='-e'
        grepArg=$2
    else
    	psArg='-ef'
    	grepArg=$1
    fi

    ps $psArg > $TEMPFILE
    head -1 $TEMPFILE && grep $grepArg $TEMPFILE
    # Empty the temp file
    # > $TEMPFILE
}

# Finding all files with a given extension.
findext() {
    if [ -f $1 ]; then
        echo "First argument is not a directory."
    elif [ ! -d $1 ]; then
        echo "$1 doesn't exist."
    fi

    find $1 -name "*.$2" >> $TEMPFILE && cat $TEMPFILE | grep $2
}

# Checking if a text file has last line empty
emptylastline()
{
    fileName=$1
    if [ -z "$(tail -c 1 "$fileName")" ]
    then
        echo "Newline at end of file!"
    else
        echo "NO newline at end of file!"
    fi
}

# sudo wrapper if I want to log something before it's execution
sudo() {
    argsString="$*"
    eval "/usr/bin/sudo $argsString"
}

# TODO: add gpg to WSL
# Encypring a single file
gencrypt() {
    fileName=$1
    gpg --output $fileName.gpg --encrypt --recipient fleshthps@gmail.com $fileName && rm -r $fileName
}

#  Decriptying a single file
gdecrypt() {
    fileName=$1
    gpg --output $fileName --decrypt $fileName.gpg
}

# Making a new directory and cd-ing to it
mkdircd() {
    # Create all nonexistent directories and go there 
    if [ $1 = '-p' ] || [ $1 = '--parents']; then 
        mkdir -p $2 && cd $2
        return 0
    fi

    newDirPath=$1
    IFSdefault="$IFS"
    IFS="/"                                         
    read -ra ARR <<< "$newDirPath"                  # split string by a delimter
    IFS="$IFSdefault"                               # restorE the defauilt delemeter to inital value
    lastDirLength=$(( ${#ARR[-1]} * -1 ))          
    initialDir=${1:0:$lastDirLength}                # Slice the newDir path without the new directory name
    
    if [ -d "$initialDir" ]; then
        mkdir $newDirPath && cd $newDirPath
    else
        echo $initialDir "doesnt exists"
    fi
}

goto() {
    if [ $1 = 'dev' ]; then 
        cd ~/dev-projects/
    elif [ $1 = 'pra' ]; then
        cd ~/dev-projects/practice-projects/
    elif [ $1 = 'api' ]; then
        cd ~/dev-projects/SEE-STAR/api
    elif [ $1 = 'web' ]; then
        cd ~/dev-projects/SEE-STAR/seekmedicare-web
    elif [ $1 = 'rx' ]; then
        cd ~/dev-projects/SEE-STAR/intelrx
    elif [ $1 = 'agent' ]; then
        cd ~/dev-projects/SEE-STAR/agent
    elif [ $1 = 'consumer' ]; then
        cd ~/dev-projects/SEE-STAR/consumer
    elif [ $1 = 'blue' ]; then
        cd ~/dev-projects/SEE-STAR/bluebutton
    elif [ $1 = 'twi' ]; then
        cd ~/dev-projects/SEE-STAR/twilio
    fi
}

opn() {
    if [ $1 = 'api' ]; then
        code ~/dev-projects/SEE-STAR/api
    elif [ $1 = 'web' ]; then
        code ~/dev-projects/SEE-STAR/seekmedicare-web
    elif [ $1 = 'agent' ]; then
        code ~/dev-projects/SEE-STAR/agent
    elif [ $1 = 'rx' ]; then
        code ~/dev-projects/SEE-STAR/intelrx
    elif [ $1 = 'consumer' ]; then
        code ~/dev-projects/SEE-STAR/consumer
    elif [ $1 = 'cli' ]; then
        code ~/.cli-tools
    elif [ $1 = 'blue' ]; then
        code ~/dev-projects/SEE-STAR/bluebutton
    elif [ $1 = 'twi' ]; then
        code ~/dev-projects/SEE-STAR/twilio
    elif [ $1 = 'all' ]; then
        code ~/dev-projects/SEE-STAR/agent
        code ~/dev-projects/SEE-STAR/api
        code ~/dev-projects/SEE-STAR/intelrx
    fi
}

run() {
    if [ $1 = 'api' ]; then
        cd ~/dev-projects/SEE-STAR/api && yarn dev
    elif [ $1 = 'web' ]; then
        cd ~/dev-projects/SEE-STAR/seekmedicare-web && yarn dev
    elif [ $1 = 'all' ]; then
        cd ~/dev-projects/SEE-STAR/agent && r
        cd ~/dev-projects/SEE-STAR/api && r
        cd ~/dev-projects/SEE-STAR/intelrx && r
    elif [ $1 = 'dbs' ]; then
        docker start api-redis && echo "api-redis started"
        docker start intelrx-mongodb && echo "intelrx-mongodb started"
    fi
}

babl() {
   jsFile="$1.js"
   compiledJsFile="$1-compiled.js"
   npx babel $jsFile -o $compiledJsFile && node $compiledJsFile  
}

n() {
    argsString="$*"
    npm $argsString;
}

y() {
    argsString="$*"
    yarn $argsString;
}

show() {
    argsString="$*"
    if [ $1 = "prv" ]; then
        ls . -al | grep " \.[a-zA-Z]"
    else
        ls $argsString;
    fi
}

yapr() {
    start=`date +"%s.%3N"`
    rf node_modules
    end=`date +%s.%3N`
    runtime=$( echo "$end - $start" | bc -l )
    echo -e "${RED}Deleted node_modules in "$runtime"s${NC}"
    yarn install
}

k() {
    kill $(lsof -t -i:$1)
}

getArgsString() {
    if [ $# -gt 1 ]; then
        argsString="$*"
        echo 'many'
        return ''"$argsString"
    else
        echo 'one'
        return "$1"
    fi
}
