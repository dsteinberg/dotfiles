set nocompatible

" auto-install plug if it doesn't exist
if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
      silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall | source $MYVIMRC
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall | source $MYVIMRC
    endif
endif

call plug#begin('~/.vim/plugged')

" Nice colour styles
" Plug 'jellybeans.vim'
" Plug 'jnurmine/Zenburn'
Plug 'w0ng/vim-hybrid'
" Plug '29decibel/codeschool-vim-theme'
" Plug 'vim-scripts/twilight'
" Plug 'jonathanfilip/vim-lucius'

" Automatic bracket completion
" Plug 'Raimondi/delimitMate'

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" NOTE, for language integrations, type these 
" - python, :CocInstall coc-python
" - latex, :CocInstall coc-vimtex
" - texlab, :CocInstall coc-texlab  (requires pacin texlab)
" - html, :CocInstall coc-html
" - css, :CocInstall coc-css
" - json, :CocInstall coc-json
" - colors, :CocInstall coc-highlight  previews colors

" Python PEP8 indentation
Plug 'hynek/vim-python-pep8-indent'

" Comment-out stuff
Plug 'tpope/vim-commentary'

" File Browser and finder
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'

" Latex Environment
"  NOTE: requires latekmk package
Plug 'reedes/vim-wordy'
Plug 'lervag/vimtex'

" Nicer buffer information display 
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'

" List tags, object properties etc 
" NOTE: needs exuberant-ctags packages
Plug 'majutsushi/tagbar'

" Buffer Displays
Plug 'jeetsukumaran/vim-buffergator'

" Git Integration
Plug 'tpope/vim-fugitive'

" Always highlight enclosing parentheses
Plug 'Yggdroot/hiPairs'

call plug#end()


" Default Formatting and Indenting
set autoindent
set textwidth=79
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smarttab  " tab width determined by shiftwidth
syntax on
set spell spelllang=en_au  " spelling always on, even in code comments  
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
set laststatus=2    " Make sure status line always shows
set background=dark
set cursorline
" set relativenumber
" colorscheme zenburn
" colorscheme codeschool
" colorscheme twilight
colorscheme hybrid
" colorscheme lucius
" colorscheme jellybeans
" highlight ColorColumn guibg=#292929


" GUI specific appearance
set guioptions=agi
" set guifont=Ligconsolata:h22
if has('gui_gtk3')
    set guifont=Fira\ Code\ Light\ 12
else
    set guifont=Fira\ Code\ Light:h28
endif
let g:neovide_cursor_vfx_mode = "railgun"


" Neovim settings
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set mouse=a
endif
if exists('g:GtkGuiLoaded')
  let g:GuiInternalClipboard=1
endif


" Buffer settings with X
" NOTE: this requires the 'xsel' package
set clipboard=unnamed,unnamedplus


" Misc Vim Settings
set pastetoggle=<F2> " Get GUI pasting working
set autochdir        " Make vim automatically change dir to buffer's dir
noremap! jk <Esc>


" Screen lines instead of global lines
nnoremap j gj
nnoremap k gk


" Fast buffer changing
nnoremap <C-Tab>   :bn<CR>
nnoremap <C-S-Tab> :bp<CR>


" Remove temptation
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>
nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>


" Change block indent continuously
vmap < <gv
vmap > >gv 

" One line indent
nmap < <<
nmap > >>


" Coc-completion configuration

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other
" plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-x> to trigger completion.
inoremap <silent><expr> <c-x> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for
" current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature 
" of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: 
" coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout 
" `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" NERDTree file browser
nnoremap <leader>f :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1


" Highlight parentheses
let g:hiPairs_hl_matchPair   = { 'term'   : 'bold',
            \                    'guifg'  : 'Green',
            \                    'cterm'  : 'bold',
            \                    'ctermfg': 'Green'
            \                  }
let g:hiPairs_hl_unmatchPair = { 'term'   : 'bold',
            \                    'guifg'  : 'Red',
            \                    'cterm'  : 'bold',
            \                    'ctermfg': 'Red'
            \                  }               


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


" Lightline settings
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ 'tabline' : {
    \   'left': [['buffers']], 'right': [['close']]
    \ },
    \ 'component_expand' : {
    \   'buffers': 'lightline#bufferline#buffers' 
    \ },
    \ 'component_type' : {
    \   'buffers': 'tabsel'
    \ }
    \ }


" HTML editing setup
autocmd BufNewFile,BufRead *.j2 set filetype=html
autocmd FileType html setlocal spell spelllang=en_au
autocmd FileType html,j2 setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2


" Haskell editing setup
autocmd FileType haskell setlocal tabstop=2 shiftwidth=2


" LaTeX editing setup
let g:tex_flavor='latex'
augroup ft_tex
    au!
    au FileType tex setlocal formatoptions="" 
    au FileType tex setlocal textwidth=0
    au FileType tex setlocal wrapmargin=0
    au FileType tex setlocal wrap
    au FileType tex setlocal breakindent
    au FileType tex setlocal shiftwidth=2 
    au FileType tex setlocal tabstop=2 
    au FileType tex setlocal spell spelllang=en_au
    au FileType tex setlocal iskeyword+=: 
    au FileType tex setlocal colorcolumn=
    au FileType tex setlocal linebreak
augroup END
let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ]}


" Make tmp dirs in standard places
set backupdir=~/.tmp,~/tmp,/var/tmp,/tmp
set undodir=~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.tmp,~/tmp,/var/tmp,/tmp
