# ============================================= PATHS == #

export PATH=$PATH:/usr/local/git/bin
source ~/.cinderella.profile
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# ============================================= PYTHON == #

alias python='python2.7'
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"

function set_django() {
    # add the current directory and the parent directory to PYTHONPATH
    # sets DJANGO_SETTINGS_MODULE
    export PYTHONPATH=$PYTHONPATH:$PWD/..
    export PYTHONPATH=$PYTHONPATH:$PWD
    if [ -z "$1" ]; then 
        x=${PWD/\/[^\/]*\/}
        export DJANGO_SETTINGS_MODULE=$x.settings
    else    
        export DJANGO_SETTINGS_MODULE=$1
    fi

        echo "DJANGO_SETTINGS_MODULE set to $DJANGO_SETTINGS_MODULE"
}

# ============================================= ALIASES == #

# == Dir navigation == #

alias ..='cd ..'
#alias cd..='cd ..'
alias .='echo $PWD'
alias ~='cd ~'
#alias more='less'

# == File/Dir Managemenet == #

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# ============================================= MORE ALIASES == #

alias ntp="sudo /usr/sbin/ntpdate time-a.nist.gov"
#alias nano='nano -w'
alias vim='vim -X'
#alias xcomp='xcompmgr -cCfF -r7 -o.65 -l-10 -t-8 -D7'
#alias m='mate'
#alias ss='./script/server'

# ============================================= COLORS == #

# @see http://norbauer.com/notebooks/code/notes/ls-colors-and-terminal-app
# @see http://plug-and-pray.blogspot.com/2008/02/lscolors.html

# == Setup == #

DIR=fx
SYM_LINK=gx
SOCKET=fx
PIPE=ax
EXE=cx
BLOCK_SP=dx
CHAR_SP=dx
EXE_SUID=hb
EXE_GUID=ad
DIR_STICKY=ex
DIR_WO_STICKY=hx
export LSCOLORS="$DIR$SYM_LINK$SOCKET$PIPE$EXE$BLOCK_SP$CHAR_SP$EXE_SUID$EXE_GUID$DIR_STICKY$DIR_WO_STICKY"
export CLICOLOR="YES"

# == Aliases == #

alias ls='ls -G'
alias lsa='ls -laG'
alias grep='grep --color=auto'

# ============================================= UNICODE == #

#alias xterm='xterm -u8'
#alias screen='screen -U'

# ============================================= SUDO == #

#alias root='sudo su'
#alias pacman='sudo pacman'
#alias apt-get='sudo apt-get'
#alias aptitude='sudo aptitude'

# ============================================= CONSOLE == #

# Makes console terminal pretty
# Slightly modified phraktured's

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0121212" #black
    echo -en "\e]P8474747" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9982b2b" #red
    echo -en "\e]P25b762f" #darkgreen
    echo -en "\e]PA89b83f" #green
    echo -en "\e]P3AA9943" #dark yellow
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P4324c80" #darkblue
    echo -en "\e]PC2b4f98" #blue
    echo -en "\e]P55F5A90" #darkmagenta
    echo -en "\e]PD826ab1" #magenta
    echo -en "\e]P692b19e" #darkcyan
    echo -en "\e]PEa1cdcd" #cyan
    echo -en "\e]P7ffffff" #lightgrey
    echo -en "\e]PFdedede" #white
    clear #for background artifacting
fi

# ============================================= MORE COLORS == #

if [ -f ~/.dir_colors ]; then
            eval `dircolors ~/.dir_colors`
fi