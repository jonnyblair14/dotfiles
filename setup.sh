debianFlag='false'
fedoraFlag='false'
alacrittyFlag='false'
nvimFlag='false'
tmuxFlag='false'
zoxideFlag='false'
rustupExists=''

# TODO: update package manager commands to include '-y'

# TODO: create temp folder for downloads and remove it at the end.

print-usage() {
	echo "======================"
	echo "usage temp placeholder"
	echo "======================"
	# TODO: Write usage output
}

Ensure-Rustup() {
	rustup update || rustupExists='false'
	if [[ ${rustupExists} = 'false' ]]; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		rustup update
	fi
}

while getopts 'dfantz' flag; do
	case "${flag}" in
	d) debianFlag='true' ;;
	f) fedoraFlag='true' ;;
	a) alacrittyFlag='true' ;;
	n) nvimFlag='true' ;;
	t) tmuxFlag='true' ;;
	z) zoxideFlag='true' ;;
	*)
		print-usage
		exit 1
		;;
	esac
done

# === DEBUG USE ===
# echo ${debianFlag}
# echo ${fedoraFlag}
# echo ${alacrittyFlag}
# echo ${nvimFlag}
# echo ${tmuxFlag}
# echo ${zoxideFlag}

if [[ ${debianFlag} = 'true' ]]; then
	sudo apt update
	sudo apt install git stow fzf python3 curl
	python3 -m pip install --user pipx
	python3 -m pipx ensurepath

	git submodule init
	git submodule update

	if [[ ${tmuxFlag} = 'true' ]]; then
		# install tmux
		sudo apt install tmux

		# link dotfiles
		stow tmux
	fi
	stow bash
fi

if [[ ${fedoraFlag} = 'true' ]]; then
	sudo dnf update
	sudo dnf install git stow fzf python3 curl
	python3 -m pip install --user pipx
	python3 -m pipx ensurepath

	git submodule init
	git submodule update

	if [[ ${tmuxFlag} = 'true' ]]; then
		# install tmux
		sudo dnf install tmux

		# link dotfiles
		stow tmux
	fi
	stow bash
fi

if [[ ${alacrittyFlag} = 'true' ]]; then
	# dependencies
	Ensure-Rustup

	# alacritty install
	cargo install alacritty

	# link dotfiles
	stow alacritty
fi

if [[ ${nvimFlag} = 'true' ]]; then
	# dependencies
	sudo apt install make unzip gcc ripgrep fd-find

	# nvim install
	curl -o nvim-linux-x86_64.tar.gz https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
	tar xzvf nvim-linux-x86_64.tar.gz -C /opt

	# nvim remote install
	pipx install neovim-remote

	# tree-sitter install
	Ensure-Rustup
	curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

	rustup update

	cargo binstall tree-sitter

	# link dotfiles
	stow nvim
fi

if [[ ${zoxideFlag} = 'true' ]]; then
	# dependencies
	Ensure-Rustup

	# install zoxide
	cargo install zoxide --locked
fi
