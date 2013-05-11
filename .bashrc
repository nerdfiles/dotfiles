#!/bin/bash

source ~/.bash_profile

[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

alias mutt='/opt/local/bin/mutt'

# ============================================= VIRTUALENV/WRAPPER == #

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Sites
export VIRTUALENVWRAPPER_PYTHON=/Library/Frameworks/Python.framework/Versions/2.7/bin/python
#export VIRTUALENVWRAPPER_PYTHON=/Users/nerdfiles/.pythonbrew/pythons/Python-2.7.2/bin/python
export PIP_VIRTUALENV_BASE=$WORKON_HOME # Tell pip to create its virtualenvs in $WORKON_HOME.
#export PIP_REQUIRE_VIRTUALENV=true
#export PIP_RESPECT_VIRTUALENV=true # Tell pip to automatically use the currently active virtualenv.
# http://keito.me/tutorials/macosx_path
export PATH=/usr/local/bin:/Library/PostgreSQL/8.4/bin:$PATH

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

function githubthis() {
  #curl -u $1:$2 https://api.github.com/user/repos -d "{\"name\":\"$3\"}"
  curl -u $1 https://api.github.com/user/repos -d "{\"name\":\"$2\"}"
}

function gitin() {

  # USAGE:
  # $ gitin 'USER' 'REPO'

  touch readme.markdown
  touch .gitignore
  touch .requirements
  mkdir .downloads
  touch .downloads/.empty

  # init project folder
  git this; 
  
  # add repo url
  git hubbed git@github.com:$1/$2.git; 

  # create repo on host
  githubthis $1 $2; 

  # first up
  git up master;

}

# ============================================= NODE == #

export NODE_PATH="/usr/local/lib/node_modules"

# ============================================= PYTHON == #

function work() {
  debug=0
  cur="$PWD"
  s=$cur
  set -- "$s" 
  IFS="/"; declare -a Array=($*) 
  len=${#Array[@]}
  len=($len-1)
  proj=${Array[$len]}
  proj=${proj/"-"/"_"}
  
  if [[ ! -d "$HOME/.virtualenvs/$proj" && ! -L "$HOME/.virtualenvs/$proj" ]]; then
    mkvirtualenv --no-site-packages --distribute $proj
  fi

  if [[ -d "$HOME/.virtualenvs/$proj" ]]; then
    workon $proj

    echo "Now working with: "
    echo "~/.virtualenvs/$proj/bin/python"
    echo "~/.vi"
    cpy
    if [ $debug ]
    then
      echo 'nana'
    else
      which python
    fi
  fi
}

# general path munging
PATH=${PATH}:~/bin
PATH=${PATH}:/usr/local/bin

# postgres
export PATH=${PATH}:/usr/local/pgsql/bin
export PGDATA=/usr/local/pgsql/data

# configure my multi-line prompt
#$PS1="\[\033[G\]$PS1"
#PS1='
#$PWD
#==> '

#-----#
# X11 #
#-----#
export DISPLAY=:0.0
PATH=${PATH}:/usr/X11R6/bin

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


#function _update_ps1()
#{
#   export PS1="$(~/powerline-bash.py $?)"
#}

# Poweline style bash prompt!
#export PROMPT_COMMAND="_update_ps1"

# ============================================= ALIASES == #

alias factit="elinks -dump randomfunfacts.com | sed -n '/^| /p' | tr -d \|"
#alias fact='echo ""; factit; echo "";'
alias factoid="factit | pbcopy"
function fact() {
  factoid;
  pbpaste > ~/.facts;
  echo "";
  pbpaste;
  echo "";
}

alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"
alias cpy='python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()" | pbcopy'
alias suspend='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

# == Dir navigation == #

## get rid of command not found ##
alias cd..='cd ..'
 
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias .='pwd'
alias ~='cd ~'
alias more='less'

alias bc='bc -l'
alias sha1='openssl sha1'
function genpass() {
  openssl rand -base64 $1 | cut -c1-$1
}
alias mount='mount |column -t'
alias unmount='sudo diskutil umount force'
# handy short cuts #
alias h='history'
alias j='jobs -l'

alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'

# get web server headers #
alias header='curl -I'
 
# find out if remote server supports gzip / mod_deflate or not #
alias headerc='curl -I --compress'

# become root #
alias root='sudo -i'
alias su='sudo -i'

# play all music files from the current directory #
#alias playwave='for i in *.wav; do mplayer "$i"; done'
#alias playogg='for i in *.ogg; do mplayer "$i"; done'
#alias playmp3='for i in *.mp3; do mplayer "$i"; done'

alias wget='wget -c'

# the "kp" alias ("que pasa"), in honor of tony p.
alias kp="ps auxwww"
alias ss="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background &"

# == LS 

alias lsl='ls -mrA' # "list"
alias lsL='ls -s | more'
alias lsa='ls -lar' # all
alias lsr='ls -spr' # reverse alpha
alias lsR='ls -R'
alias lsp='ls -p' # column dir
alias l='ls -AlGFh'
## Show hidden files ##
alias l.='ls -d .* --color=auto'

# == File/Dir Managemenet == #

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

# ============================================= MORE ALIASES == #

alias ntp="sudo /usr/sbin/ntpdate time-a.nist.gov"
alias vim='vim -X'
alias m='mate'
alias grep='grep --color=auto'

# ============================================= UNICODE == #

#alias xterm='xterm -u8'
#alias screen='screen -U'

# ============================================= SUDO == #

#alias root='sudo su'
#alias pacman='sudo pacman'
#alias apt-get='sudo apt-get'
#alias aptitude='sudo aptitude'

alias pbrew='pythonbrew'

# Compass
#########

alias compassing='rvm use 1.9.3-p125; compass watch compass'
alias touchcompass='rvm use 1.9.3-p125; compass create compass'

alias glr='git pull --rebase && fact'
alias fuck_it="git commit -am 'cleanup docs ubuntu version'; git push origin dev; fab sync_staging; fab pull_staging; git checkout dev"
alias gitcleanup="git aa; git acm 'cleanup'; git up dev; git checkout master; git down master; git merge dev; git up master; git checkout dev;"
alias sup="top -o cpu"
alias io='sudo iosnoop'
alias exe='sudo execsnoop'
alias _iotop='sudo iotop -CP 1'
alias syshack='man -k dtrace'

alias nightlychrome='open -a Nightly\ Chrome.app'
alias hiddenchrome='open -a Nightly\ Chrome.app --args --incognito'

alias kippt='workon kipptin; python ~/Sites/kipptin/kippthon/main.py'

source $HOME/.gvm/scripts/gvm
export PATH="$HOME/Library/Haskell/bin:$PATH"
PATH=$HOME/.cabal/bin:$PATH

alias ported='lsof -i | grep LISTEN'

alias macvim='mvim'

alias opclean='sudo sh /etc/periodic/weekly/*;sudo sh /etc/periodic/daily/*;sudo sh /etc/periodic/monthly/*'

# Start up MongoDB using a forked process and log appending 
alias mongostart='/var/mongodb/bin/mongod --fork --dbpath /var/mongodb/data/db --logpath /var/mongodb/log/mongodb.log --logappend' 
# Shut down MongoDB safely using the soft kill on the PID 
alias mongostop="kill -2 `ps aux | grep [m]ongo* | awk '{ print $2 }'`"

alias redisstart='launchctl start io.redis.redis-server'
alias redisstop='launchctl stop io.redis.redis-server'

#alias kipptin='sendmail inbox+Dzexw08fXIzzwPTf5hsUe7ZTvQH@kippt.it'
#alias readlater='sendmail readlater+Dzexw08fXIzzwPTf5hsUe7ZTvQH@kippt.it'

#alias prepmail='(cat <<EOCAT'

# echo "<b>HTML Message goes here</b>" | mail -s "$(echo -e "This is the subject\nContent-Type: text/html")" foo@example.com

function prepmail() {
  #echo "$1" | mail -s "$(echo -e "$2\nContent-Type: text/html\nMIME-Version: 1.0\nFrom: \"Aharon <nerdfiles@gmail.com>\"")" $3
  #( 
  #echo "From: nerdfiles <nerdfiles@gmail.com>"
  #echo "To: $3"; echo "MIME-Version: 1.0"
  #echo "Content-Type: text/html" 
  #echo "Subject: $2" 
  #echo ""
  #echo "$1"
  #) | sendmail -t
  echo "$1" | mutt -e 'set content_type="text/html"' $3 -s "$2"
}

function kipptin() {
  echo "$1" | mutt -e 'set content_type="text/html"' inbox+Dzexw08fXIzzwPTf5hsUe7ZTvQH@kippt.it -s "Kippt it!"
}

function readlater() {
  echo "$1" | mutt -e 'set content_type="text/html"' readlater+Dzexw08fXIzzwPTf5hsUe7ZTvQH@kippt.it -s "Kippt it!"
}

#MAIL=/var/spool/mail/nerdfiles && export MAIL
MAIL=/val/spool/postfix/active && export MAIL

alias mate='open -a TextMate.app; echo "Opening TextMate 2...";'
alias sublime='open -a Sublime\ Text\ 2.app; echo "Opening Sublime Text 2...'
alias gridwars='open -a gridwars.app; echo "You really should be working, sir."'
alias bbt2='open -a BBT2.app; echo "Opening BBT2...";'
alias burnnn='open -a Burn.app; echo "Burn something good."'
alias byword='open -a Byword.app'
alias theautomator='open -a Automator.app'
alias photoshop='open -a Adobe\ Photoshop\ CS5.app'
alias lightroom='open -a Adobe\ Lightroom\ 3.app'
export EDITOR=macvim
source "`brew --prefix grc`/etc/grc.bashrc"
[ -s "/Users/nerdfiles/.scm_breeze/scm_breeze.sh" ] && source "/Users/nerdfiles/.scm_breeze/scm_breeze.sh"

#alias gmvault='/Users/nerdfiles/.virtualenvs/gmvault/bin/gmvault'

# Django Aliases
################

alias jangy='python manage.py'
alias jangyrun='find . -name "*.pyc" -exec rm "{}" ";"; echo "Recursively removed *.pyc files!"; python manage.py clearcache; python manage.py runserver_plus'
alias jangyshell='python manage.py shell'
alias jangysql='python manage.py sql'
alias jangysqlall='python manage.py sqlall'
alias jangystartapp='django-admin.py startapp'
alias jangystartproject='django-admin.py startproject'
alias jangysync='python manage.py syncdb'
alias jangydump='python manage.py dumpdata --exclude=contenttypes --natural'
alias jangyload='python manage.py loaddata'
alias jangycleanup='python manage.py cleanup'
alias jangyflush='python manage.py flush'
alias jangydbshell='python manage.py dbshell'
alias jangyinspect='python manage.py inspectdb'
alias jangymigrate='python manage.py migrate'
alias jangyschemamigration='python manage.py schemamigration'
alias jangyevolve='python manage.py evolve --hint --execute'
alias jangygenfix='python manage.py generate_fixture'
alias jangydumpobj='python manage.py dump_object'


# CoffeeScript Aliases 
######################

alias makecoffee='coffee --compile --output' # lib/ src/
alias brewcoffee='coffee --watch --compile' # file.coffee
alias grindcoffee='coffee --join project.js --compile' # src/*.coffee
alias pourcoffee='coffee -bpe'
alias servecoffee='coffee -o lib/ -cw src/'


PATH=/usr/local/bin:/usr/local/sbin:${PATH}

function snapsnap() {
  #ddd = date 
  imagesnap -q /Users/nerdfiles/Desktop/clams/snaps/$1;
}

#alias snapsnap='snap'
alias dconnect='sudo ifconfig en1 down'
alias rconnect='sudo ifconfig en1 up'
alias spoof='sudo ifconfig en1 ether'
alias somegems='rvm list gemsets'
alias whoser='rvm gemset list'
alias rover='rvm info'

alias py?='which python'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

alias twat="sh twat.sh"

echo ""; cat ~/.facts; echo "";

#logout() {
#  osascript -e 'tell application "System Events" to log out'
#  builtin logout
#}

#function topcmds() {
#  history | awk '{print $2}' | awk 'BEGIN {FS="|"}{print $1}' | sort | uniq -c | sort -nr | head
#}

function topcmds() {
  history | awk 'BEGIN {FS="[ \t]+|\\|"} {print $3}' | sort | uniq -c | sort -nr | head
}

#trap 'fact; exit 0' 0
#fact
alias nerds!="ssh nerdfiles@nerdfiles.net"
alias lynx='/Applications/Lynxlet.app/Contents/Resources/lynx/bin/lynx'

function got() {
  lynx http://google.com?q="$1"
}
alias dumplinks="elinks -dump"
alias startwars="telnet towel.blinkenlights.nl"
alias ql="qlmanage -p"
#alias enable_spotlight="sudo chmod 755 /System/Library/CoreServices/Spotlight.app"
#alias disable_spotlight="sudo chmod 0 /System/Library/CoreServices/Spotlight.app"
alias dir="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"

function mkalias() {
  echo "$1" >> ~/.bashrc
}

alias getinfo="/Users/nerdfiles/getinfo.sh"

function __mode_single() {
  defaults write com.apple.dock single-app -bool true 
  killall Dock 
}

function __mode_multi() {
  defaults delete com.apple.dock single-app
  killall Dock 
}

function sshtunnel() {
  ssh -D 8080 -f -C -q -N $1@$2 #ssh -f $1@$2 -L 2000:$2:25 -N
}

function smithing() {

  # recursively
  if [[ $1 == '__recursively' ]]; then
    find . -type f -exec grep -il "$2" {} \;
  fi

  #or if you know the file type
  if [[ $1 == '__typically' ]]; then
    find . -type f -user nerdfiles -name "*.$3" -exec grep -il "$2" {} \;
  fi
  # and/ or if you just want your files
  if [[ $1 == '__aimlessly' ]]; then
      find . -type f -name "*.$3" -exec grep -il "$2" {} \;
  fi

}

alias fb='fbcmd'
alias fql='fb FQL'

function fb_post() {
  fb WALLPOST "$1" "$2"
}

function fb_post_img() {
  fb WALLPOST "$1" IMG 0 "$2" 0
}

alias fb_posts='fb FQL "SELECT status_id,message,time,source FROM status WHERE uid=[me]" | less'

alias fb_wall='fb FSTREAM =me'
alias fb_wall_new='fb FSTREAM =me new'

alias fb_threads='fb FQL "SELECT thread_id, subject, recipients, snippet FROM thread WHERE folder_id = 0" | less'

alias fb_inbox='fb INBOX -tid | less'

alias fb_harvest='fb FSTATUS | less' # harvest statuses
alias fb_harvest_links='fb FSTATUS | urlview'
alias fb_harvest_posts_links='fb FQL "SELECT status_id,message,time,source FROM status WHERE uid=[me]" | urlview'

alias fb_recent='fb RECENT | less' # recently touched

alias fb_lsq='fb STREAM 1 20 | less' # quick harvest of touched


# fb_link
# 
# message = $1
# name = $2
# link = $3

function fb_link() {
  
  fb POST "$1" "$2" "$3"

}

function fb_img_cap() {
  fb POST IMG "$1" "$2" "$3"
}

function fb_img() {
  fb POST IMG 0 "$1" 0
}

alias fb_co='fb COMMENT'

#alias fb_ls='fb STREAM 1'
function fb_ls() {
  fb STREAM 1 $1 | less
}

#alias fb_lookup='fb ALLINFO'
function fb_lookup() {
  fb ALLINFO $1 | less
}

alias fb_online='echo "# -*- viewing: Creeps -*- #"; fb FONLINE | less'

alias surf_hn='open http://news.ycombinator.com'
alias surf_hn_new='open http://news.ycombinator.com/newest'
alias surf_slashdot='open http://slashdot.org'
alias surf_bash='open http://bash.org/?latest'
alias surf_soundcloud='open http://soundcloud.com/nerdfiles'
alias surf_webjournal='open http://webjournal.nerdfiles.net/'
alias surf_webjournal_dash='open http://webjournal.nerdfiles.net/wp-admin/'
alias surf_bristow='open http://bristowgroup.com/'
alias surf_bristow_dash='open http://bristowgroup.com/dashboard'
alias surf_github='open http://github.com/'
alias surf_nerds!='open http://nerdfiles.net'
alias surf_nerds_dash='open http://nerdfiles.net/dashboard'
alias surf_webhost='open http://my.webfaction.com/'
alias html5='python /Users/nerdfiles/Tools/html5check.py'


