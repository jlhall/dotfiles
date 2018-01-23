#!/usr/bin/env zsh
set -ex

HTTP_GIT="https://github.com/jlhall/dotfiles.git"
SSH_GIT="git@github.com:jlhall/dotfiles.git"

set_git_urls () {
	# Change dotfiles remote so I can push
	git remote set-url origin $SSH_GIT
	# Set up HTTP remote for easy pull
	git remote add http $HTTP_GIT
}

install_prezto () {
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB

  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
      ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
}

echo "Set up dotfiles..."
set_git_urls

echo "Set up Prezto..."
install_prezto

echo "Running bootstrap..."
./script/bootstrap.sh

echo "Setup SSH..."
./ssh/setup.sh

chsh -s /bin/zsh

echo "Done!"
