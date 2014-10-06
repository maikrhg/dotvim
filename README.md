# dotvim #

My dotvim directory (now with vundle)

## Installation ##

    cd ~
    git clone git@github.com:maikrhg/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    mkdir ~/.vim_tmp (optional)
    cd ~/.vim
    git submodule init
    git submodule update
    vim
    :BundleInstall

Install Ag (the silver searcher) with Homebrew:

    brew install ag

## Upgrade all bundles ##

    :BundleInstall!
