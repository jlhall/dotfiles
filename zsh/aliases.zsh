alias reload!='. ~/.zshrc'
alias spot='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --app=https://play.spotify.com --kiosk'
alias update="_update && reload!"
alias lic="cp $ZSH/LICENSE LICENSE"
alias as='alias | grep'
alias c="cd $PROJECTS"
alias rm='nocorrect rm'
alias dot="cd $ZSH"
alias x='unarchive'
alias notes="e ~/Dropbox/notes"
# toggle seeing dotfiles or not
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias vssh='vagrant ssh'
alias ferr='pbpaste | jsonpp | grep exc_info'
alias grod='git rebase -i origin/develop'
alias grom='git rebase -i origin/master'
alias create_tags="ctags -R --exclude=.git --exclude=node_modules --exclude=venv"
alias cpu="top -ocpu -s10"
alias emacs="open /Applications/Emacs.app"

# on mac, haskell's `stack` gets a zsh auto-correct to java's `jstack` ugh
alias hstack="stack"

# see the last few commits
alias showCommits='git log -n 5 --date=rfc-local'

# interactive rebase against origin/$1
function ir {
  branch=${1-master}
  if [ "$branch" = "master" ]
  then
    printf "You didn't pass a branch, presuming you want master\n"
  fi
  sleep 2
  git rebase -i origin/$branch
}

# cleans up local branches that haven't seen a commit in 2 weeks
function prune {
  delete=${1-d}
  for k in $(git branch | sed /\*/d); do
    if [ -z "$(git log -1 --since='2 weeks ago' -s $k)" ]; then
      git branch -$delete $k
    fi
  done
}

# full ir using function for common rebase workflow
function gitsucks {
  project=$1
  ticket=$2
  basebranch=${3-master}
  chain "gco $basebranch" gp "ttam $project $ticket" "ir $basebranch"
}

function pfxit {
  project=$1
  ticket=$2
  gitsucks $project $ticket develop
}

function fxit {
  project=$1
  ticket=$2
  gitsucks $project $ticket
}

function int-get {
  job=${1}
  url="https://JENKINS_URL/${job}/config.xml"
  curl -X GET "${url}" -u "USERNAME:TOKEN" --create-dirs -o "./configs/${1}/config.xml"
}

function int-post {
  url="https://USER:TOKEN@JENKINS_HOST_NAME/createItem?name=${1}"
  curl -X POST "${url}" --data-binary "@./configs/${1}/config.xml" -H "Jenkins-Crumb:JENKINS_CRUMB" -H "Content-Type:text/xml"
}

function fuck-jenkins {
 int-get "${1}" && int-post "${1}"
}

function vdo {
  vagrant ssh -c "$*"
}

function lsdir {
  find $1 -type d -name "*$2*"
}

# yes I'm really that lazy
function see {
  ls -alh ${1-.}
}

# this doesn't tell the diff between repeated commands, but that shouldn't be an issue
# this one is for make
function mm {
  for last; do true; done
  final=""
  for var in "$@"
  do
    if [ "$var" = "$last" ]
    then
      final+="make $var"
    else
      final+="make $var && "
    fi
  done
  eval $final
}

# this doesn't tell the diff between repeated commands, but that shouldn't be an issue
# this one is for generic chaining
function chain {
  for last; do true; done
  final=""
  for var in "$@"
  do
    if [ "$var" = "$last" ]
    then
      final+="$var"
    else
      final+="$var && "
    fi
  done
  eval $final
}

# check given port for processes (to likely murder with sudo kill)
function wtf {
  sudo lsof -i :$1
}

# bye bye .DS_Store
alias no_ds_store='find . -name ".DS_Store" -print0 | xargs -0 rm -rf'

# Find out what ports are in use
alias ports="netstat -tulpn"

# Spoof MAC address (ex spoof 00:00:00:00:00:00)
alias spoof="sudo ifconfig en0 ether"

alias proxy="echo 'proxy at 127.0.0.1:3128' && ssh -D 3128 -CN kbl.io -p 3128"

# Make directory and change into it.
md (){ mkdir -p "$*"; cd "$*"; }

# Alias pbcopy from OSX
if ((! $ISMACOS))
    then
    alias pbcopy='xclip -selection clipboard'
fi
