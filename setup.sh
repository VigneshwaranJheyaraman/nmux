#!/usr/bin/env bash

OPT_DIR=~/opt
if [[ ! -d $OPT_DIR ]]; then
	echo "creating ~/opt directory"
	mkdir -p $OPT_DIR
fi
CONFIG_DIR=~/.config
NEOVIM_DIR_NAME=neovim
NEOVIM_DIR=$OPT_DIR/$NEOVIM_DIR_NAME
NEOVIM_BIN=$NEOVIM_DIR/bin
BREW_DIR=/opt/homebrew

function command_exists() {
    command -v "$1" &> /dev/null
}

function setup_homebrew() {
	if command_exists "brew"; then
		echo "skipping homebrew installation it already exists"
	else
		echo "Installing homebrew be ready to input your password as \"su-doers\""
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
	fi
}

function brew_install_util() {
	tool_to_install=$1
	command=${2:-$tool_to_install}
	echo "trying to install $command without dependencies"
	if ! command_exists "$command"; then
		brew install $tool_to_install
	else
		echo "$command already exists"
	fi
}

function install_dev_tools() {
	echo "setting up dev tools"
	brew_install_util "make"
	brew_install_util "jq"
	brew_install_util "openjdk@21" "java"
	brew_install_util "postgresql@18" "psql"
	brew_install_util "clojure" && brew uninstall -ignore-dependencies openjdk@26
	brew_install_util "nvm"
	brew_install_util "cmake"
	brew_install_util "tmux"
	brew_install_util "gh"
}

function install_ai_tools() {
	echo "setting up AI/ LLM tools"
	brew_install_util "ollama"
	brew tap jundot/omlx https://github.com/jundot/omlx && brew trust jundot/omlx && brew_install_util "omlx"
	brew_install_util "opencode" && brew uninstall --ignore-dependencies node
}

function setup_zsh() {
	if [ ! -d ~/.oh-my-zsh ]; then
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
}

function setup_neovim() {
	cd $OPT_DIR
	if [ ! -d $NEOVIM_DIR ]; then
		echo "nvim cloning"
		git clone https://github.com/neovim/neovim -b stable $NEOVIM_DIR_NAME
		cd $NEOVIM_DIR
	else
		echo "nvim pulling"
		cd $NEOVIM_DIR && git pull origin --rebase stable
	fi
	if [ ! -d $NEOVIM_BIN ]; then
		make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$NEOVIM_DIR
		make install
	fi
	if ! $(PATH=$PATH:$NEOVIM_BIN command_exists "nvim"); then
		echo "issue with neovim install"
		exit 1
	fi
}

function setup_nmux() {
	cd $OPT_DIR
	if [ ! -d $CONFIG_DIR ]; then
		mkdir -p $CONFIG_DIR
	fi
	nmux_dir=$OPT_DIR/nmux
	if [ ! -d $nmux_dir ]; then
		git clone https://github.com/VigneshwaranJheyaraman/nmux.git
	else
		cd $nmux_dir && git pull origin master
	fi
	echo "setting neovim config"
	cp -rf $nmux_dir/nvim $CONFIG_DIR/nvim
	echo "setting opencode config"
	cp -rf $nmux_dir/opencode $CONFIG_DIR/opencode
	echo "setting clojure-lsp config"
	cp -rf $nmux_dir/clojure-lsp $CONFIG_DIR/clojure-lsp
	echo "setting tmux config"
	cp -rf $nmux_dir/.tmux.conf ~/.tmux.conf
	echo "setting clojure config"
	cp -rf $nmux_dir/.clojure ~/.clojure
}

function init() {
	setup_homebrew
	install_dev_tools
	setup_neovim
	setup_nmux
	setup_zsh
	install_ai_tools
	cd $OPT_DIR
}
