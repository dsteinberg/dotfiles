set nocompatible

" auto-install plug if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Nice colour styles
Plug 'jellybeans.vim'
Plug 'jnurmine/Zenburn'
Plug 'w0ng/vim-hybrid'
Plug '29decibel/codeschool-vim-theme'
Plug 'vim-scripts/twilight'
Plug 'jonathanfilip/vim-lucius'

" Better tab completion 
"  NOTE: if you are using python, make sure you install all the JEDI packages,
"   (python2) and ALSO python-vim (python 2)!!! 
"  NOTE: You may need to install python-vim from pip (and pip2)
"  NOTE: On Arch, you may need the aur/libtinfo package for an appropriate
"   simlink
Plug 'maralla/completor.vim'

" Python Documentation Viewer
Plug 'fs111/pydoc.vim'

" Python PEP8 indentation
Plug 'hynek/vim-python-pep8-indent'

" Comment-out stuff
Plug 'tpope/vim-commentary'

" File Browser and finder
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'

" Syntax checker 
" NOTE: requires flake8 packages, python3-flake8, python-flake8, pyflakes
Plug 'w0rp/ale'

" Latex Environment
"  NOTE: requires latekmk package
Plug 'LaTeX-Box-Team/LaTeX-Box'

" Nicer buffer information display 
"  NOTE: requires pip package?
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'taohex/lightline-buffer'

" List tags, object properties etc 
" NOTE: needs exuberant-ctags packages
Plug 'majutsushi/tagbar'

" Buffer Displays
Plug 'jeetsukumaran/vim-buffergator'

" Git Integration
Plug 'tpope/vim-fugitive'

call plug#end()


" Default Formatting and Indenting
set autoindent
set textwidth=79
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smarttab "tab width determined by shiftwidth
syntax on
set foldmethod=indent
set foldlevel=99


" Visual Appearance
set ruler
set colorcolumn=80
set scrolloff=10
set ttyfast
set lazyredraw
set number
set showtabline=2
set t_Co=256        " Approx GUI colour in terminals
set laststatus=2    " Make sure status line always shows
set background=dark
" set relativenumber
" colorscheme zenburn
" colorscheme codeschool
" colorscheme twilight
colorscheme hybrid
" colorscheme lucius
" colorscheme jellybeans
" highlight ColorColumn guibg=#292929

" GUI specific appearance
if has('gui_running')
    set guioptions=agim
    set guifont=Inconsolata\ for\ Powerline\ 14
    " set guifont=Roboto\ Mono\ for\ Powerline\ 13
    " set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 13
    " set guifont=Anonymous\ Pro\ for\ Powerline\ 14
    " set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 13
endif


" Misc Vim Settings
set pastetoggle=<F2> " Get GUI pasting working
set autochdir        " Make vim automatically change dir to buffer's dir
noremap! jk <Esc>


" Fast buffer changing
nnoremap <C-Tab>   :bn<CR>
nnoremap <C-S-Tab> :bp<CR>


" Remove temptation
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>
nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>


" Change block indent continuously
vmap <S-Tab> <gv
vmap <Tab>   >gv 


" One line indent
nmap <S-Tab> <<
nmap <Tab>   >>


" Completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"


" When vimrc is edited, reload it
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END


" Syntax Checking and Documentation
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


" NERDTree file browser
nnoremap <leader>f :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1


" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" BufferGator Settings
let g:buffergator_suppress_keymaps = 1
let g:buffergator_autoexpand_on_split = 1
" nnoremap <leader>T :BufferGatorTabsOpen<CR>
nnoremap <leader>b :BuffergatorToggle<CR>
nnoremap gb        :BuffergatorMruCyclePrev<CR>
nnoremap gB        :BuffergatorMruCycleNext<CR>


" TagBar settings
nnoremap <leader>t :TagbarOpenAutoClose<CR>
let g:tagbar_left = 1


" LaTeX-Box Settings
let g:LatexBox_viewer = 'evince'
let g:LatexBox_ref_pattern = '\c\\\a*ref\*\?\_\s*{' " complete all ref commands
let g:LatexBox_latexmk_options = '-bibtex' " put -c for continuous compilation
let g:LatexBox_show_warnings = 0


" Powerline settings
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'tabline': {
        \ 'left': [[ 'bufferinfo' ], [ 'bufferbefore', 'buffercurrent', 'bufferafter' ],],
        \ 'right': [[ 'close' ],],
        \ },
    \ 'component_expand': {
        \ 'buffercurrent': 'lightline#buffer#buffercurrent2',
        \ },
    \ 'component_type': {
        \ 'buffercurrent': 'tabsel',
        \ },
    \ 'component_function': {
        \ 'bufferbefore': 'lightline#buffer#bufferbefore',
        \ 'bufferafter': 'lightline#buffer#bufferafter',
        \ 'bufferinfo': 'lightline#buffer#bufferinfo',
        \ },
    \ }


" HTML editing setup
autocmd BufNewFile,BufRead *.j2 set filetype=html
autocmd FileType html setlocal spell spelllang=en_au
autocmd FileType html,j2 setlocal omnifunc=htmlcomplete#CompleteTags


" LaTeX editing setup
autocmd FileType tex setlocal spell spelllang=en_au iskeyword+=:
let g:tex_flavor='latex'


" TXT and MD editing setup
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_au
autocmd FileType markdown setlocal spell spelllang=en_au
autocmd FileType rst setlocal spell spelllang=en_au


" Make tmp dirs in standard places
set backupdir=~/.tmp,~/tmp,/var/tmp,/tmp
set undodir=~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.tmp,~/tmp,/var/tmp,/tmp
