" set up vim plug
call plug#begin('~/.vim/plugged')

Plug 'ayu-theme/ayu-vim'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'luochen1990/rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/rainbow_parentheses.vim'

call plug#end()


syntax on
set number

set encoding=utf8

set clipboard=unnamed " set yank to system keyboard

set autoindent " always set autoindenting on

set copyindent " copy the previous indentation on autoindenting

set expandtab " expand tabs by default (overloadable per file type)

set shiftround " use multiple of shiftwidth when indenting with '<' and '>'

set shiftwidth=4 " number of spaces to use for autoindenting

set smartindent
set cindent
set smarttab " insert tabs on the start of a line according to shiftwidth, not tabstop

set softtabstop=4 " when hitting <BS>, pretend like a tab is removed, even if spaces

set tabstop=4 " tabs are n spaces
set mouse+=a

" color support
set termguicolors
let ayucolor="mirage"
colorscheme ayu

" rainbow brackets on
let g:rainbow_active = 0
let g:rainbow_conf = {
\    'javascript': {
\      'operators': '_,\|+\|-\|\*\|\*\*\| / \|//\|===\|!==\|==\|!=\| < \|<=\| > \|>=\|:\|%\|&\||_',
\      'parentheses_options': 'containedin=jsxElement fold ',
\      'parentheses': [
\        'start=/\z((\)/ end=/)/ contains=@jsAll', 'start=/\[/ end=/\]/ contains=@jsAll',
\        'start=/{/ end=/}/ contains=@jsAll containedin=jsTemplateString',
\        'start=_<\z([^ />]*\)>\?_ end=_</\z1>_ end=_/>_ contains=jsxOpenTag,jsxAttrib,jsxExpressionBlock,jsxSpreadOperator,jsComment,@javascriptComments,javaScriptLineComment,javaScriptComment',
\      ],
\      'after': [
\        'syn clear jsParen', 'syn clear jsFuncArgs', 'syn clear jsxExpressionBlock',
\        'syn clear jsParensError', 'syn clear jsParenIfElse', 'syn clear jsDestructuringBlock',
\        'syn clear jsFuncBlock', 'syn clear jsArrowFuncArgs', 'syn clear jsParenSwitch',
\        'syn clear jsBlock', 'syn clear jsObject', 'syn clear jsxTag', 'syn clear jsTemplateExpression',
\        'syn clear jsParenRepeat', 'syn clear jsRepeatBlock'
\      ],
\      'contains_prefix': '',
\    },
\}

" indent highlights on
let g:indent_guides_enable_on_vim_startup = 1

" mapping spacebar to leader
nnoremap <SPACE> <Nop>
let mapleader = " "

" Fast saving
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>

" Map Files to control-p
map <C-p> :Files 
" Map ag to control-f
map <C-f> :Ag 
" some fix for lightline?
set laststatus=2

" ALE linting fixer
let g:ale_fixers = {'javascript': ['eslint']}
" ALE shortcut
nmap <leader>f :ALEFix<cr>
" keep gutter open
let g:ale_sign_column_always = 1

" keep gitgutter open
set signcolumn="yes"

" map nerdtreetoggle
map <C-o> :NERDTreeToggle<CR>
" let nerdtree activate upon just "vim"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" let nerdtree auto close
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" let nerdtree activate upon "vim directory"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" let nerdtree highlight files differently depending on extension
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, guifg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermfg='. a:fg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('c', 'green', 'green') 
call NERDTreeHighlightFile('cpp', 'green', 'green')
call NERDTreeHighlightFile('ini', 'yellow', 'yellow')
call NERDTreeHighlightFile('md', 'blue', '#3366FF')
call NERDTreeHighlightFile('yml', 'yellow', 'yellow')
call NERDTreeHighlightFile('config', 'yellow', 'yellow')
call NERDTreeHighlightFile('conf', 'yellow', 'yellow')
call NERDTreeHighlightFile('json', 'yellow', 'yellow')
call NERDTreeHighlightFile('html', 'yellow', 'yellow')
call NERDTreeHighlightFile('styl', 'cyan', 'cyan')
call NERDTreeHighlightFile('css', 'cyan', 'cyan')
call NERDTreeHighlightFile('coffee', 'Red', 'red')
call NERDTreeHighlightFile('js', 'Red', '#ffa500')
call NERDTreeHighlightFile('php', 'Magenta', '#ff00ff')





" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>




