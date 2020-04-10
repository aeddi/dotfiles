" Set ~/.vim as runtimepath
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

" Load ~/.vimrc
source ~/.vimrc
