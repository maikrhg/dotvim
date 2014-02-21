# dotvim #

My dotvim directory (now with vundle)

## Installation ##

    cd ~
    git clone http://github.com/maikrhg/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    mkdir ~/.vim_tmp
    vim
    :BundleInstall

Install Ack (with Homebrew):

    brew install ack

## Upgrade all bundles ##

    :BundleInstall!
