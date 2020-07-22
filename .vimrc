" deprecated function for installing a rust plugin
" function! BuildComposer(info)
"   if a:info.status != 'unchanged' || a:info.force
"     if has('nvim')
"       !cargo build --release --locked
"     else
"       !cargo build --release --locked --no-default-features --features json-rpc
"     endif
"   endif
" endfunction

" -----------------------------------------------------------------------------
" VIM PLUG PLUGIN DEFINITIONS
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'ayu-theme/ayu-vim' " ayu mirage color scheme
Plug 'preservim/nerdtree' " file browser
Plug 'itchyny/lightline.vim' " powerline-like status line
Plug 'maximbaz/lightline-ale' " add ale to lightline
Plug 'tpope/vim-eunuch' " convenient commands that I don't use yet
Plug 'tpope/vim-surround' " helps change surrounding brackets/parens/quotes together
Plug 'airblade/vim-gitgutter' " shows which lines diff in git
Plug 'tpope/vim-fugitive' " gives tons of git power, e.g. blame by line
Plug 'editorconfig/editorconfig-vim' " uses editorconfig to inform formatting
Plug 'mattn/emmet-vim' " provides snippets, MAY DELETE IF ULTISNIPS IS JUST BETTER
Plug 'sirver/ultisnips' " may replace emmet
Plug 'w0rp/ale' " asynchronous linting engine or something
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf command
Plug 'junegunn/fzf.vim' " uses fzf for fuzzy control-p
Plug 'terryma/vim-multiple-cursors' " control-n to do multicursor work 
Plug 'neoclide/coc.nvim', {'branch': 'release'} " COC autocomplete engine
Plug 'sheerun/vim-polyglot' " auto-includes various language syntax highlighters
Plug 'nathanaelkane/vim-indent-guides' " shows indents with blocks
Plug 'tomtom/tcomment_vim' " gives the gcc and gc commands to toggle comment
Plug 'lervag/vimtex' " latex helper
Plug 'mlaursen/vim-react-snippets' " gives a lot of js and jsx snippets for react
Plug 'easymotion/vim-easymotion' " wow cheating to move around easier
" Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') } " instant markdown rendering
Plug 'suan/vim-instant-markdown', {'for': 'markdown'} " simpler markdown?
Plug 'machakann/vim-highlightedyank' " highlights yanked text
Plug 'jiangmiao/auto-pairs' " matches start and end brackets etc

call plug#end()


" -----------------------------------------------------------------------------
" GENERAL VIM STUFF
" -----------------------------------------------------------------------------
set guifont=Monaco:h12
set guicursor+=a:blinkon0
syntax on
set nocompatible
set number norelativenumber
set encoding=utf8
set clipboard=unnamed " set yank to system keyboard
set autoindent " always set autoindenting on
set copyindent " copy the previous indentation on autoindenting
set expandtab " expand tabs by default (overloadable per file type)
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'
set shiftwidth=4 " number of spaces to use for autoindenting
set smartindent
set cindent
set wrap
set linebreak " disable wrap break in middle of a word
set smarttab " insert tabs on the start of a line according to shiftwidth, not tabstop
set softtabstop=4 " when hitting <BS>, pretend like a tab is removed, even if spaces
set tabstop=4 " tabs are n spaces
set mouse+=a " make system mouse work
set nomodeline " should not be useful anymore but eh
set history=400 " expands undo hisory
set lazyredraw " might marginally increase performance
set scrolloff=1 " keeps a line of margin at boom
set backspace=indent,eol,start " supposed to make backspace bettter
set timeoutlen=1000 ttimeoutlen=20 " speeds up exiting insert mode
set hidden " TextEdit might fail if hidden is not set.
set cmdheight=2 " Give more space for displaying messages.
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" smaller number gutter
set numberwidth=3

" KEYBIND SETUP
" mapping spacebar to leader
nnoremap <SPACE> <Nop>
let mapleader = " "
nnoremap Y y$
nnoremap H ^
nnoremap L $
" toggle relative line number
nmap <leader>n :set relativenumber!<cr>
" refresh syntax highlighting
nmap <leader>syn :syn sync fromstart<cr>

" Fast saving
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
" need to press enter after that for speed

" config by filetype
filetype plugin indent on
" configure all these to have 2 space indents
autocmd FileType javascript,javascriptreact,json,html,css,scss,typescript setlocal shiftwidth=2 softtabstop=2 expandtab
" spellcheck markdown files
autocmd FileType markdown setlocal spell

" / search tools
set incsearch " Highlight searching
set showmatch
set nohlsearch " use :hlsearch if we have to
set ignorecase
set smartcase
set autoread " autoread files

" disable swps in current dir and moves backups there ttoo
set backup
set undofile
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
" Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup

" -- FOLDING -- (disabled since this is slow)
" set foldmethod=indent "syntax highlighting items specify folds
" set foldcolumn=1 "defines 1 col at window left, to indicate folding
" " let javaScript_fold=1 "activate folding by JS syntax
" set foldlevelstart=99 "start file with all folds opened

" Don't dispay mode in command line (lightline already shows it)
set noshowmode

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

set splitright " split vertical windows rightward

nmap <leader>t :term<cr>

" -----------------------------------------------------------------------------
" PLUGIN SETUP
" -----------------------------------------------------------------------------

" color support for ayu mirage
set termguicolors
let ayucolor="mirage"
colorscheme ayu

" indent highlights on
let g:indent_guides_enable_on_vim_startup = 1
" colors
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#373C47   
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#4B4F59  

" React jsx highlights on
let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1 " uhh colors?? 
let g:jsx_ext_required = 0 

" map gitgutter refresh to leader-g
nmap <leader>g :GitGutter<cr>

" Map Files to control-p
map <C-p> :Files 
" Map Rg to control-f
map <C-f> :Rg

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" -----------------------------------------------------------------------------
" LIGHTLINE SETUP
" -----------------------------------------------------------------------------
set laststatus=2
let g:lightline = {}

let g:lightline.component_expand = {
    \  'linter_checking': 'lightline#ale#checking',
    \  'linter_infos': 'lightline#ale#infos',
    \  'linter_warnings': 'lightline#ale#warnings',
    \  'linter_errors': 'lightline#ale#errors',
    \  'linter_ok': 'lightline#ale#ok',
    \ }

let g:lightline.component_type = {
    \     'linter_checking': 'right',
    \     'linter_infos': 'right',
    \     'linter_warnings': 'warning',
    \     'linter_errors': 'error',
    \     'linter_ok': 'right',
    \ }

let g:lightline.component_function = {
        \ 'gitbranch': 'FugitiveHead',
        \ 'cocstatus': 'coc#status',
        \ 'currentfunction': 'CocCurrentFunction',
        \ 'fileformat': 'LightlineFileformat',
        \ 'fileencoding': 'LightlineFileEncoding',
        \ 'filename': 'LightlineFilename',
        \ 'filetype': 'LightlineFiletype',
        \ }

let g:lightline.active = { 
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'gitbranch', 'readonly', 'filename' ],
        \           [ 'cocstatus', 'currentfunction' ] ] 
        \ ,
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'fileformat', 'fileencoding', 'filetype' ],
        \            [ 'linter_checking', 'linter_errors', 'linter_warnings',
        \ 'linter_infos', 'linter_ok' ]
        \            ] }

function! LightlineFileformat()
  return winwidth(0) > 110 ? &fileformat : ''
endfunction

function! LightlineFileEncoding()
  return winwidth(0) > 110 ? &fileencoding : ''
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! CocCurrentFunction()
    return winwidth(0) > 90 ? get(b:, 'coc_current_function', '') : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 40 ? (&filetype !=# '' ? (&filetype !=# 'javascriptreact' ? &filetype : 'react.jsx') : 'no ft') : ''
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" -----------------------------------------------------------------------------
" FUGITIVE SETUP
" -----------------------------------------------------------------------------
" grab diff from right side during merge
nmap <leader>gl :diffget //3<CR>
" left side
nmap <leader>gh :diffget //2<CR>
" open git status
nmap <leader>gs :G<CR>
" open merge panes
nmap <leader>gm :Gdiffsplit!<CR>

" -----------------------------------------------------------------------------
" ALE SETUP
" -----------------------------------------------------------------------------

let g:ale_linters = 
        \{
            \'css': ['stylelint'],
            \'scss': ['stylelint'],
            \'html': ['htmlhint'],
            \'cpp': ['clang'],
            \'c': ['clang']
        \}
let g:ale_linters_explicit = 1
let g:ale_fixers =
        \{
            \'javascript': ['eslint'],
            \'javascriptreact': ['eslint'],
            \'html': ['prettier'],
            \'css': ['stylelint'],
            \'scss': ['stylelint'],
            \'cpp': ['clang-format'],
            \'c': ['clang-format']
        \} 
" ALE fixer shortcut
nmap <leader>f :ALEFix<cr>
" keep lint gutter open
let g:ale_sign_column_always = 1
" cooler gutter signs??
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '●'
highlight ALEErrorSign ctermbg=NONE ctermfg=red guifg=#ff0000
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow guifg=#fab005
" fix ugly highlights
highlight ALEError ctermbg=242 cterm=underline term=none ctermfg=none guibg=#645C73
highlight ALEWarning ctermbg=242 cterm=underline term=none ctermfg=none guibg=#398E89

map <leader>at :ALEToggle<CR>

" jump between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" quickfixing
let g:ale_set_quickfix = 1
let g:ale_open_list = 0

" custom error message
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s (%code%) [%severity%]'

" -----------------------------------------------------------------------------
" NerdTree Config
" -----------------------------------------------------------------------------

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
" NERDTree File highlighting
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
call NERDTreeHighlightFile('jsx', 'Red', '#ffa500')
call NERDTreeHighlightFile('php', 'Magenta', '#ff00ff')

let g:NERDTreeShowHidden = 1
" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" -----------------------------------------------------------------------------
" COC autocomplete engine setup
" -----------------------------------------------------------------------------

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
execute 'vert h '.expand('<cword>')
else
call CocActionAsync('doHover')
endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
highlight CocHighlightText ctermbg=242 guibg=#343F4C
highlight CocErrorHighlight ctermbg=242 cterm=underline term=none ctermfg=none gui=undercurl guibg=#645C73
" highlight link CocErrorLine CocErrorSign 
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fo  <Plug>(coc-format-selected)
nmap <leader>fo  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" this freezes vim for some reason
" xmap <leader>aa  <Plug>(coc-codeaction-selected)
" nmap <leader>aa  <Plug>(coc-codeaction-selected)

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
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" -----------------------------------------------------------------------------
"  VIMTEX OPTIONS
"  ----------------------------------------------------------------------------
" if has('unix')
"     if has('mac')
"         let g:vimtex_view_method = "skim"
"         let g:vimtex_view_general_viewer
"                 \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
"         let g:vimtex_view_general_options = '-r @line @pdf @tex'
"
"         " This adds a callback hook that updates Skim after compilation
"         let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
"         function! UpdateSkim(status)
"             if !a:status | return | endif
"
"             let l:out = b:vimtex.out()
"             let l:tex = expand('%:p')
"             let l:cmd = [g:vimtex_view_general_viewer, '-r']
"             if !empty(system('pgrep Skim'))
"             call extend(l:cmd, ['-g'])
"             endif
"             if has('nvim')
"             call jobstart(l:cmd + [line('.'), l:out, l:tex])
"             elseif has('job')
"             call job_start(l:cmd + [line('.'), l:out, l:tex])
"             else
"             call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
"             endif
"         endfunction
"     else
"         let g:latex_view_general_viewer = "zathura"
"         let g:vimtex_view_method = "zathura"
"     endif
" elseif has('win32')
"
" endif
"
" let g:tex_flavor = "latex"
" let g:vimtex_quickfix_open_on_warning = 0
" let g:vimtex_quickfix_mode = 2
" if has('nvim')
"     let g:vimtex_compiler_progname = 'nvr'
" endif
" let g:vimtex_quickfix_mode=0
" set conceallevel=1 " set to 0 if hidden stuff gets confusing
" let g:tex_conceal='abdmg' 
"
" " Can hide specifc warning messages from the quickfix window
" " Quickfix with Neovim is broken or something
" " https://github.com/lervag/vimtex/issues/773
" let g:vimtex_quickfix_latexlog = {
"             \ 'default' : 1,
"             \ 'fix_paths' : 0,
"             \ 'general' : 1,
"             \ 'references' : 1,
"             \ 'overfull' : 1,
"             \ 'underfull' : 1,
"             \ 'font' : 1,
"             \ 'packages' : {
"             \   'default' : 1,
"             \   'natbib' : 1,
"             \   'biblatex' : 1,
"             \   'babel' : 1,
"             \   'hyperref' : 1,
"             \   'scrreprt' : 1,
"             \   'fixltx2e' : 1,
"             \   'titlesec' : 1,
"             \ },
"             \}
"
" -----------------------------------------------------------------------------
" Utilisnips setup
" -----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger = '<C-l>'
let g:UltiSnipsJumpForwardTrigger = '<C-l>'
let g:UltiSnipsJumpBackwardTrigger = '<C-h>'

" -----------------------------------------------------------------------------
" emmet setup
" -----------------------------------------------------------------------------
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

" -----------------------------------------------------------------------------
" markdown setup
" -----------------------------------------------------------------------------

" slow down refresh of markdown display server so insert mode isn't so laggy
" refreshes upon normal mode, no recent keypresses, or save file
let g:instant_markdown_slow = 1
" enables mathjax!
let g:instant_markdown_mathjax = 1
