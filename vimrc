set nocompatible

" Begin Vundle Stuff
filetype off " required!

" vim-scripts repos: http://vim-scripts.org/vim/scripts.html
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Easy plugin installer
Plugin 'gmarik/Vundle.vim'

" Nice colour styles
Plugin 'jellybeans.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'w0ng/vim-hybrid'
Plugin 'jonathanfilip/vim-lucius'
Plugin '29decibel/codeschool-vim-theme'
Plugin 'vim-scripts/twilight'

" Better tab completion 
"  NOTE: install C++ bits with ./install.sh --clang-completer --system-libclang
"  NOTE: if you are using python, make sure you install all the JEDI packages!
Plugin 'Valloric/YouCompleteMe'

" Python tab completion
Plugin 'davidhalter/jedi-vim'

" Comment-out stuff
"Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-commentary'

" File Browser and finder
"Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'

" Syntax checker 
" NOTE: requires flake8 packages, python3-flake8, python-flake8, pyflakes
Plugin 'scrooloose/syntastic'

" Latex Environment
"  NOTE: requires latekmk package
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" Python Documentation Viewer
Plugin 'fs111/pydoc.vim'

" Nicer buffer information display 
"  NOTE: requires pip package?
Plugin 'bling/vim-airline'

" List tags, object properties etc 
" NOTE: needs exuberant-ctags packages
Plugin 'majutsushi/tagbar'

" Buffer Displays
Plugin 'jeetsukumaran/vim-buffergator'

" Git Integration
"Plugin 'tpope/vim-fugitive'

filetype plugin indent on " required!
" End Vundle Stuff


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
set t_Co=256        " Approx GUI colour in terminals
set laststatus=2    " Make sure status line always shows
"set relativenumber
"colorscheme zenburn
colorscheme codeschool
"colorscheme twilight
"colorscheme hybrid
"colorscheme lucius
"colorscheme jellybeans
"highlight ColorColumn guibg=#292929


" GUI specific appearance
if has('gui_running')
    set guioptions=agim
    set guifont=Inconsolata\ for\ Powerline\ 14
endif


" Misc Vim Settings
set pastetoggle=<F2> " Get GUI pasting working
set autochdir        " Make vim automatically change dir to buffer's dir
noremap! jk <Esc>
nnoremap <C-Tab>   :bn<CR>
nnoremap <C-S-Tab> :bp<CR>
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

" When vimrc is edited, reload it
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END


" Syntax Checking
let g:syntastic_cpp_check_header = 1
let g:syntastic_python_python_exec = '/usr/bin/python3'
"let g:syntastic_python_checker_args='--ignore=E501,E225'
"let g:syntastic_cpp_compiler = 'g++'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -Wall'


" NERDTree file browser
nnoremap <leader>f :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1


" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif


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


" YouCompleteMe settings (using Jedi for python)
let g:ycm_filetype_blacklist = {
      \ 'tex' : 1,
      \ 'latex' : 1,
      \}

" Jedi settings (mainly to stop hints unless called for)
" autocmd FileType python setlocal completeopt-=preview 
" let g:jedi#show_call_signatures = 0
" let g:jedi#popup_on_dot = 0

" LaTeX-Box Settings
let g:LatexBox_viewer = 'evince'
let g:LatexBox_ref_pattern = '\c\\\a*ref\*\?\_\s*{' " complete all ref commands
let g:LatexBox_latexmk_options = '-bibtex' " put -c for continuous compilation
let g:LatexBox_show_warnings = 0


" Airline settings
let g:airline_powerline_fonts = 1  " This needs the powerline fonts
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = ' '


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


" Make tmp dirs in standard places
set backupdir=~/.tmp,~/tmp,/var/tmp,/tmp
set undodir=~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.tmp,~/tmp,/var/tmp,/tmp
