#!/bin/sh
if type "apt-get" > /dev/null 2>&1; then
  apt-get update
  apt-get install -y libncurses5-dev silversearcher-ag
fi

curl -s https://api.github.com/repos/uji/ujivim/releases/latest \
| grep "browser_download_url.*linux-amd64.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| xargs curl -o ~/ujivim.tar.gz -L

tar -zxvf ~/ujivim.tar.gz -C ~/
echo export PATH=$PATH:$HOME/ujivim/bin >> ~/.bash_env
echo export VIM=$HOME/ujivim/share/vim >> ~/.bash_env

sh ~/dotfiles/common.sh
sh ~/dotfiles/ln.sh

export VIM=$HOME/ujivim/share/vim
$HOME/ujivim/bin/vim -c 'call minpac#clean()' \
    -c 'call minpac#update("", {"do": "quit"})' \
    -c ':q'
