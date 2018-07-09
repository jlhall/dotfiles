alias ga="git add"
alias gam="git commit --amend -C HEAD"
alias gb='git branch'
alias gbrm=git-delete-local-merged
alias gc='git commit -m'
alias gco='git checkout'
alias gcom='git checkout master'
alias gd='git diff'
alias gf='git fetch --all --prune'
alias ggf='git ls-files | grep'
alias gg="git grep -I --ignore-case --line-number --full-name --color --break --heading --context 2 --show-function"
alias gglog='git log --patch -G '
alias gp='git pull'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gme="glog --author=\"Jonathan Hall\""
alias greset="git reset --hard"
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gs='git status -sb'
alias gpo='git push origin'

# Create new feature branch.
gcob() { git checkout -b feature/$1; }

# pass ttam project and ticket to checkout the associated branch
# will break for multi-branch situations
ttam() {
  project=$1
  ticket=$2
  git branch -a | grep -v remotes | grep -i $project"-"$ticket | xargs git checkout;
}

# RIP some unfortunate branch... buh bye
rip() {
  delete=${2-d}
  gb | grep $1 | while read -r line ; do
    echo "Processing $line"
    gb -$delete $line
  done
}

# Generate a gitignore to stdout
# gi linux,osx,python
gi() { curl -s https://www.gitignore.io/api/$@ ;}
