set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
au TermOpen * setlocal nonumber norelativenumber

source ~/.vimrc

nmap <leader>t :split term://fish<cr>
