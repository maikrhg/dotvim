# dotvim #

My dotvim directory (now with vundle)

## Installation ##

    cd ~
    git clone git@github.com:maikrhg/dotvim_vundle.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    mkdir ~/.vim_tmp
    cd ~/.vim
    git submodule init
    git submodule update
    vim
    :BundleInstall

Install Ack (with Homebrew):

    brew install ack

## Upgrade all bundles ##

    :BundleInstall!
