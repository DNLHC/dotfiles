#!/usr/bin/env bash

mkdir -p /home/$USER/.ssh
ln -sr ./nvim /home/$USER/.config/
ln -sr ./lf /home/$USER/.config/
ln -sr ./ssh/config /home/$USER/.ssh/config
ln -sr ./tmux.conf /home/$USER/tmux.conf
ln -sr ./.vimrc /home/$USER/.vimrc
ln -sr ./.gitconfig /home/$USER/.gitconfig
ln -sr ./.bash_aliases /home/$USER/.bash_aliases
ln -sr ./.imwheelrc /home/$USER/.imwheelrc

echo "if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases fi" >> ~/.bashrc
echo -e "export NODE_OPTIONS=\"--max-old-space-size=4096\"" >> ~/.bashrc
echo -e "export EDITOR=\"nvim\"" >> ~/.bashrc

sudo dnf install "dnf-command(config-manager)" -y
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo -y
sudo dnf copr enable pennbauman/ports -y
sudo dnf install ripgrep gh fd-find neovim lf fzf make automake gcc gcc-c++ kernel-devel -y

curl https://get.volta.sh | bash
source ~/.bashrc

volta install node
volta install @fsouza/prettierd prettier eslint_d eslint stylelint @johnnymorganz/stylua-bin cspell npm-check-updates tsc

