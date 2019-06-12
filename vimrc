" Set compatibility to Vim only.
set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on Pathogen plugin manager
execute pathogen#infect()

" Turn on Plug plugin manager
call plug#begin()
" Make sure you use single quotes
Plug 'lifepillar/vim-mucomplete'
Plug 'davidhalter/jedi-vim' " need to pip install jedi
Plug 'xavierd/clang_complete' " need to install clang and then add 'let g:clang_library_path= <path to libclang.dll> '
" For first time init need to call ':PlugInstall'
" Initialize plugin system
call plug#end()

" Turn on syntax highlighting.
syntax on

" Default typeless files to python filetype/syntax
autocmd BufEnter * if &syntax == "" | setlocal syntax=python | endif
autocmd BufEnter * if &filetype == "" | setlocal filetype=python | endif

" For plug-ins to load correctly.
filetype plugin indent on

" Turn off modelines
set modelines=0

" Automatically wrap text that extends beyond the screen length.
set nowrap
" Vim's auto indentation feature does not work properly with text copied from outisde of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Uncomment below to set the max textwidth. Use a value corresponding to the width of your screen.
" set textwidth=79
set formatoptions=tcqrn1
set tabstop=8
set shiftwidth=4
set softtabstop=0
set expandtab
set noshiftround
set smarttab

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Status bar
set laststatus=2

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Encoding
set encoding=utf-8

" Display different types of white spaces.
set list
set listchars=tab:\ \ ,trail:·,extends:#,nbsp:. " ,space:·

" Show line numbers
set number

" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase
" Show completion options when using tab-completion for commands
set wildmenu
" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

" Tab navigation like Browser.
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap th     :tabprevious<CR>
nnoremap tl     :tabnext<CR>
nnoremap tt     :tabnew<CR>
nnoremap tw     :tabclose<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Set automatic folds for code files (can set to indent for python files in '.vim/after/ftplugin/python.vim')
set foldmethod=syntax

" Automatically save and load folds
if has("win32")
  set viewdir=$HOME/vimfiles/view
endif
" autocmd BufWinLeave ?* mkview
" autocmd BufWinEnter ?* silent loadview"

augroup AutoSaveFolds
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

" Automatically open all folds when opening a file
autocmd BufWinEnter ?* silent! :%foldopen!

" GVIM settings
if has("gui_running")
  if has("gui_win32")
    colorscheme darkblue
    set guifont=Consolas:h14:cANSI:qDRAFT
  else
    set guifont=Inconsolata\ 12
  endif
endif

set completeopt+=menuone
set completeopt+=noinsert
set shortmess+=c
set belloff+=ctrlg
set completeopt-=preview
set completeopt+=longest,menuone,noselect
"let g:jedi#popup_on_dot = 0  " It may be 1 as well
let g:mucomplete#enable_auto_at_startup = 1
