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
"  NOTE: install C++ bits with ./install.sh --clang-completer --system-libclang
"  NOTE: if you are using python, make sure you install all the JEDI packages,
"   (python2) and ALSO python-vim (python 2)!!! 
"  NOTE: This requires python2, it may be worth modifying the install.py script
"   python_binary = '/usr/bin/python2'
"  NOTE: You may need to install python-vim from pip (and pip2)
"  NOTE: On Arch, you may need the aur/libtinfo package for an appropriate
"   simlink
" Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/neocomplete.vim'

" Comment-out stuff
Plug 'tpope/vim-commentary'

" File Browser and finder
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'

" Syntax checker 
" NOTE: requires flake8 packages, python3-flake8, python-flake8, pyflakes
Plug 'scrooloose/syntastic'

" Latex Environment
"  NOTE: requires latekmk package
Plug 'LaTeX-Box-Team/LaTeX-Box'

" Python Documentation Viewer
Plug 'fs111/pydoc.vim'

" Python PEP8 indentation
Plug 'hynek/vim-python-pep8-indent'

" Nicer buffer information display 
"  NOTE: requires pip package?
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" List tags, object properties etc 
" NOTE: needs exuberant-ctags packages
Plug 'majutsushi/tagbar'

" Buffer Displays
Plug 'jeetsukumaran/vim-buffergator'

" Git Integration
Plug 'tpope/vim-fugitive'

" Haskell Syntax (cabal install hdevtools)
" Plug 'bitc/vim-hdevtools'
" Plug 'dag/vim2hs'

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
    " set guifont=Anonymous\ Pro\ for\ Powerline\ 14
    " set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 11.8
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
inoremap <C-Space> <C-x><C-o>
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif


" When vimrc is edited, reload it
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END


" Syntax Checking and Documentation
let g:syntastic_cpp_check_header = 1
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:pydoc_cmd = 'python3 -m pydoc'
let g:syntastic_python_flake8_args='--ignore=W503,E731'


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


"use omnicomplete whenever there's no completion engine in youcompleteme (for
"example, in the case of PHP)
set omnifunc=syntaxcomplete#Complete


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
autocmd FileType rst setlocal spell spelllang=en_au


" Make tmp dirs in standard places
set backupdir=~/.tmp,~/tmp,/var/tmp,/tmp
set undodir=~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.tmp,~/tmp,/var/tmp,/tmp
