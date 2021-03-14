set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc

nmap <leader>t :split term://fish<cr>
tnoremap <C-w> <C-\><C-n><C-w>
tnoremap <C-b> <C-\><C-n>

autocmd BufEnter * :IndentGuidesEnable

autocmd TermOpen * setlocal nospell
au TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen,BufEnter term://* startinsert
autocmd TermOpen,BufEnter term://* :IndentGuidesDisable
autocmd BufLeave term://* stopinsert
" autocmd TermClose,BufLeave term://* :IndentGuidesEnable
autocmd TermClose * bd! " quit when a terminal closes instead of showing exit code and waiting

autocmd User Startified setlocal buflisted " fixes a bug with startify and floating windows
