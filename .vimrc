"        _
" __   _(_)_ __ ___ This is my
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_\_/ |_|_| |_| |_|_|  \___|
" Vim configuration file 

" In NORMAL mode, 'zo' expands a fold, 'zc' collapses it, 
" 'zR' expands all folds, 'zM' collapses them all.


" SETTINGS:
" Global Defaults: ------------------------------------------------------- {{{


    set nocompatible

" Enable syntax and plugins (for netrw)
    syntax enable
    filetype plugin on


" }}}

" Finding Files: --------------------------------------------------------- {{{

" Search down into subfolders
" Provides tab-completion for all file-related tasks
    set path+=**

" Display all matching files when we tab complete
    set wildmenu
    set wildmode=longest,list,full
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

" }}}

" Tag Jumping: ----------------------------------------------------------- {{{

" Create the 'tags' file (May need to install ctags first)
    command! MakeTags !ctags -R .

" NOW WE CAN:
" - use ^j to jump to tag under cursor
" - use g^j for ambiguous tags
" - use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" }}}

" File Browsing: --------------------------------------------------------- {{{

    let g:netrw_banner=0        " Disable annoying banner
    let g:netrw_browse_split=4  " Open in prior window
    let g:netrw_altv=1          " Open splits to the right
    let g:netrw_liststyle=3     " Tree view
    let g:netrw_list_hide=netrw_gitignore#Hide()
    let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\s\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
    
" }}}

" Build Integration: ----------------------------------------------------- {{{

" Steal Mr. Bradley's formatter & add it to our spec helper
" <http://philipbradley.net/rspec-intovim-with-quickfix>

" Configure the 'make' command to run RSpec
    set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter

" NOW WE CAN:
" - Run :make to run RSpec
" -     :cl to list errors
" -     :cc# to jump to error by number
" -     :cn and :cp to navigate forward and back

" }}}

" General Configuration: ------------------------------------------------- {{{

" Sets how many lines of history VIM has to remember
    set history=500

" Set to auto read when a file is changed from the outside
    set autoread
    au FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
    let mapleader = " "

" Fast saving
    nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
    command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" }}}

" Text Rendering: -------------------------------------------------------- {{{

    set encoding=utf-8
    set linebreak
    set textwidth=500
    set scrolloff=8
    set sidescrolloff=5
    set showmatch
    set termguicolors
    set emoji
" If using tmux, this fixes vim color display issues
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" Let's continue...
    let g:seoul256_background = 233
    colo seoul256

" }}}

" User Interface: -------------------------------------------------------- {{{

    set ruler
    set number
    set colorcolumn=100
    highlight ColorColumn ctermbg=Red cterm=bold guibg=#420d09
    set signcolumn=yes
    set title
    set mouse=ni
    set backspace=eol,start,indent
    set whichwrap+=<,>,h,l
    
" }}}

" Auto Completion: ------------------------------------------------------- {{{

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick)
" - ^x^j for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - use ^n and ^p to go back and forth in the suggestion list

" }}}

" Tabs And Indentation: -------------------------------------------------- {{{

    set expandtab    

    set smarttab

    set shiftround
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4

    filetype indent on
    set autoindent
    set smartindent
    set wrap

    " }}}

" Cursor: ---------------------------------------------------------------- {{{

" Use a line cursor within INSERT mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> Blinking block
"   Ps = 1  -> Blinking block (default)
"   Ps = 2  -> Steady block
"   Ps = 3  -> Blinking underline
"   Ps = 4  -> Steady underline
"   Ps = 5  -> Blinking bar (xterm)
"   Ps = 6  -> Steady bar (xterm)
    let &t_SI = "\e[6 q\e]"
    let &t_EI = "\e[1 q\e]"

    set guicursor=
    set cursorline
    set cursorcolumn
    highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b
    highlight CursorColumn ctermbg=Yellow cterm=bold guibg=#2b2b2b

" }}}

" In File Search: -------------------------------------------------------- {{{

    set hlsearch
    set ignorecase
    set incsearch
    set smartcase

" }}}

" Undo: ------------------------------------------------------------------ {{{

    set noswapfile
    set nobackup
    set writebackup

" If Vim version is equal to or greater than 7.03, enable undofile.
" This allows you to undo changes to a file, even after saving it.
if version >= 703
    set undodir=~/.vim/undodir
    set undofile
    set history=1000
endif

" }}}

" Miscellaneous: --------------------------------------------------------- {{{

    set hidden
    set spell
    
"sets dictionary files for iab
    set dictionary=~/.vim/skeleton/dic.lst

"use CTRL+N to autocomplete from dictionary
    set dictionary+=/usr/share/dict/words
    set complete+=.,w,b,u,t,i,kspell,k
    set iskeyword+=-

" }}}

" Spellchecking: --------------------------------------------------------- {{{

" Pressing '<leader>ss' will toggle spellchecking
    map <leader>ss !setlocal spell!<CR>

" Shortcuts using <leader>
    map <leader>sn ]s
    map <leader>sp [s
    map <leader>sa zg
    map <leader>s? z=

" }}}


" CONFIGURATION:
" FUNCTIONS: ------------------------------------------------------------- {{{

" call the .vimrc.functions file
    if filereadable(expand("~/.vim/config/.vimrc.functions"))
        source ~/.vim/config/.vimrc.functions
    endif

" }}}

" PLUGINS: --------------------------------------------------------------- {{{

" Plugin code goes here.

" Bootstrap vim-plug
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" Call the .vimrc.plug file
        if filereadable(expand("~/.vim/config/.vimrc.plug"))
            source ~/.vim/config/.vimrc.plug
        endif

        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
        
    
" Call the .vimrc.plug file
        if filereadable(expand("~/.vim/config/.vimrc.plug"))
            source ~/.vim/config/.vimrc.plug
        endif

" }}}

" PLUGIN CONFIGURATION: -------------------------------------------------- {{{


" Call the .vimrc.plug.config file
    if filereadable(expand("~/.vim/config/.vimrc.plug.config"))
        source ~/.vim/config/.vimrc.plug.config
    endif

" }}}

" MAPPINGS: -------------------------------------------------------------- {{{

" Mappings code goes here.

" Call the .vimrc.mapping file
    if filereadable(expand("~/.vim/config/.vimrc.mapping"))
        source ~/.vim/config/.vimrc.mapping
    endif

" }}}

" TEMPLATES: ------------------------------------------------------------- {{{

" Template code goes here.

" Call the .vimrc..template file
    if filereadable(expand("~/.vim/config/.vimrc.template"))
        source ~/.vim/config/.vimrc.template
    endif

" }}}

" VIMSCRIPT: ------------------------------------------------------------- {{{

" Vimscript code goes here.

" call the .vimrc.vimscript file
    if filereadable(expand("~/.vim/config/.vimrc.vimscript"))
        source ~/.vim/config/.vimrc.vimscript
    endif

" }}}

" STATUS LINE: ----------------------------------------------------------- {{{

" Call the .vimrc.statusline file
    if filereadable(expand("~/.vim/config/.vimrc.statusline"))
        source ~/.vim/config/.vimrc.statusline
    endif

" }}}

