#!/usr/bin/env bash

mkdir -p $HOME/.ssh
ln -sr ./nvim $HOME/.config/
ln -sr ./lf $HOME/.config/
ln -sr ./ssh/config $HOME/.ssh/config
ln -sr ./tmux.conf $HOME/tmux.conf
ln -sr ./.vimrc $HOME/.vimrc
ln -sr ./.gitconfig $HOME/.gitconfig
ln -sr ./.bash_aliases $HOME/.bash_aliases
ln -sr ./.imwheelrc $HOME/.imwheelrc
ln -sr ./ripgrep $HOME/.config/
ln -sr ./.prettierrc $HOME/.prettierrc

echo -e "\nif [ -f ~/.bash_aliases ]; then \n\t. ~/.bash_aliases \nfi" >> ~/.bashrc
echo -e "export NODE_OPTIONS=\"--max-old-space-size=4096\"" >> ~/.bashrc
echo -e "export EDITOR=\"nvim\"" >> ~/.bashrc
echo -e 'export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/rc' >> ~/.bashrc

sudo dnf install "dnf-command(config-manager)" -y
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo -y
sudo dnf copr enable pennbauman/ports -y
sudo dnf install ripgrep gh fd-find neovim lf fzf make automake gcc gcc-c++ kernel-devel -y

curl https://get.volta.sh | bash
source ~/.bashrc

volta install node
volta install @fsouza/prettierd prettier eslint_d eslint stylelint @johnnymorganz/stylua-bin cspell npm-check-updates tsc

