# dotfiles

Behold, my dotfiles

So that I don't forget how to get this back when I accidentally nuke my OS, here's some instructions that might help get it all back. I will flesh them out as I remember how I got here.

Install dependancies
```bash
sudo apt install git tmux stow nvim
```
## For neovim
```bash
sudo apt install git make unzip gcc ripgrep fd-find
curl -o nvim-linux-x86_64.tar.gz https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
./nvim-linux-x86_64/bin/nvim
pipx install neovim-remote
```
## Rustup installation
you need rust/rustup for cargo for tree sitter
```bash
# Install - https://rustup.rs/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# update packages
rustup update

# Tree-sitter-cli install - # https://crates.io/crates/tree-sitter-cli
cargo binstall tree-sitter-cli
```

need nerdfont: MesloGM NerdFont is my usual

## refresh .tmux.conf
`tmux source ~/.tmux.conf`

