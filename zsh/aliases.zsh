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

# see the last few commits
alias showCommits='git log -n 5 --date=rfc-local'

# cleans up local branches that haven't seen a commit in a week
function prune {
  delete=${1-d}
  for k in $(git branch | sed /\*/d); do
    if [ -z "$(git log -1 --since='1 week ago' -s $k)" ]; then
      git branch -$delete $k
    fi
  done
}

function vdo {
  vagrant ssh -c $1
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
