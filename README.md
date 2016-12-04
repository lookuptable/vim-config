# Installation instruction

1. Clone repo

 ```bash
 $ git clone https://github.com/lookuptable/vim-config ~/.vim
 ```

2. Update submodules to pull in Vundle.vim

 ```bash
 $ git submodule update --init --recursive
 ```

3. Install other VIM plugins via Vundle.vim

 ```bash
 $ vim +PluginInstall +qall
 ```

4. Build `YouCompleteMe`

 ```bash
 $ cd ~/.vim/bundle/YouCompleteMe
 $ ./install.py --all
 ```

And you're done!
