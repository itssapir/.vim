" Set compatibility to Vim only.
set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on Pathogen plugin manager
" execute pathogen#infect()

" Turn on Plug plugin manager
call plug#begin()
" Make sure you use single quotes
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'lifepillar/vim-mucomplete'
Plug 'rjayatilleka/vim-insert-char' " binds <Space> to enter single-char insert mode
" Plug 'davidhalter/jedi-vim' " need to pip install jedi
" Plug 'thaerkh/vim-workspace'
Plug 'preservim/nerdcommenter' " adds a lot of ways to quickly comment out code sections

" clang completion for c files
" need to install clang and then add 'let g:clang_library_path= <path to libclang.dll> '
Plug 'xavierd/clang_complete'
" search for libclang for clang_complete, otherwise disable it.
" might need to modify these paths to reflect libclang location
if filereadable(expand('/usr/lib/llvm-8/lib/libclang.so.1'))
    let g:clang_library_path='/usr/lib/llvm-8/lib/libclang.so.1'
elseif filereadable(expand('~/.vim/clang/lib/libclang.so'))
    let g:clang_library_path='~/.vim/clang/lib/libclang.so'
elseif filereadable(expand('C:\Program Files (x86)\LLVM\bin\libclang.dll'))
    let g:clang_library_path='C:\Program Files (x86)\LLVM\bin\libclang.dll'
else
    let g:clang_complete_loaded=0
endif

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

" Don't automatically wrap text that extends beyond the screen length.
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

" Always show completion menu
set completeopt+=menuone
" Only insert longest common substring from all completion possibilities
set completeopt+=longest
" Do not show extra information about the selected completion
set completeopt-=preview
" Silence some completion messages (e.g. pattern not found)
silent! set shortmess+=c
silent! set belloff+=ctrlg

" don't automatically popup suggestions when typing dot
let g:jedi#popup_on_dot = 0
" give suggestion only after typing pauses
let g:mucomplete#completion_delay = 1
" enable autocompletion plugin
let g:mucomplete#enable_auto_at_startup = 1

" Tab navigation like Browser.
" nnoremap <C-S-tab> :tabprevious<CR>
" nnoremap <C-tab>   :tabnext<CR>
" inoremap <C-S-tab> <Esc>:tabprevious<CR>i
" inoremap <C-tab>   <Esc>:tabnext<CR>i
nnoremap th     :tabprevious<CR>
nnoremap tl     :tabnext<CR>
nnoremap tt     :tabnew<CR>
nnoremap tw     :tabclose<CR>

" Map the <Space> key to toggle a selected fold opened/closed.
" nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
" vnoremap <Space> zf

" Set automatic folds for code files (can set to indent for python files in '.vim/after/ftplugin/python.vim')
set foldmethod=syntax

" Automatically save and load folds
if has("win32")
  set viewdir=$HOME/vimfiles/view
endif

augroup AutoSaveFolds
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

" Change default netrw view to extended view
let g:netrw_liststyle = 1

" Automatically open all folds when opening a file
autocmd BufWinEnter ?* silent! :%foldopen!

" GVIM display settings
if has("gui_running")
  if has("gui_win32")
    colorscheme darkblue
    set guifont=Consolas:h14:cANSI:qDRAFT
  else
    set guifont=Inconsolata\ 12
  endif
endif

