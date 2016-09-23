#!/bin/bash

install_git()
{
    echo 'Install git_config'
    cp -v gitconfig ~/.gitconfig
}

install_pip_mirror()
{
    echo 'Install pip mirrors'
    mkdir ~/.pip
    cp -v pydistutils.cfg ~/.pydistutils.cfg
    cp -v pip.conf ~/.pip/pip.conf
}

install_pip_db_mirror(){
    echo 'Install douban pip mirrors'
    mkdir ~/.pip
    cp -v pydistutils.cfg.douban ~/.pydistutils.cfg
    cp -v pip.conf.douban ~/.pip/pip.conf
}
install_byobu_keybinding()
{
    echo 'Install byobu keybinding'
    cp -v keybindings.tmux ~/.byobu/keybindings.tmux
}

install_screen()
{
    echo "Install screenrc"
    cp -v screenrc ~/.screenrc
}

install_bash()
{
    cp -v profile ~/.profile
    cp -v bashrc ~/.bashrc
}

if [[ $1 == 'git' ]];then
    install_git
elif [[ $1 == 'pip' ]]; then
    install_pip_mirror
elif [[ $1 == 'pip-db' ]]; then
    install_pip_db_mirror
elif [[ $1 == 'byobu' ]]; then
    install_byobu_keybinding
elif [[ $1 == 'all' ]]; then
    install_git
    install_pip_mirror
    install_byobu_keybinding
    install_bash
    install_screen
else
    echo "Usages: $0 <git|pip|pip-db|byobu|all>"
fi
