package_manager = apt
.PHONY: setup install-fonts install-nvim install-tmux setup-config setup-tmux-config setup-nvim-config pull-nmux setup-clojure setup-clojure-config gh-install oc-install

pull-nmux:
	if [ -z "/home/$(whoami)/nmux" ]; then
		cd /home/$(whoami)
		echo cloning nmux
		git clone https://github.com/VigneshwaranJheyaraman/nmux.git nmux
	else
		cd /home/$(whoami)/nmux
		echo pulling latest nmux
		git pull origin main
	fi

install-nvim:
	if ! command -v nvim > /dev/null; then
		echo installing neovim
		${package_manager} install nvim
	fi

install-tmux:
	if ! command -v tmux > /dev/null; then
		echo install tmux
		${package_manager} install tmux
	fi

setup-nvim-config: pull-nmux install-nvim
	echo setting up neovim configuration
	cd nmux
	cp -rf ./nvim ~/.config/nvim

setup-tmux-config: pull-nmux install-tmux
	echo setting up tmux configuration
	cd nmux
	ln -s ./.tmux.conf ~/.config/.tmux.conf

setup-config: setup-tmux-config setup-nvim-config

setup-clojure:
	echo installing clojure
	${package_manager} install clojure

setup-clojure-config: setup-clojure
	echo setting up clojure config
	cp ./repl.deps.edn /home/$(whoami)/.clojure/deps.edn


install-fonts:
	${package_manager} install font-hack-nerd-font

gh-install:
	${package_manager} install gh

oc-install:
	${package_manager} install opencode

setup: setup-config install-fonts oc-install gh-install

