" Author: James Reid <jamesreid3806@gmail.com>
" Leader key general usage (most leader key commands follow this pattern):
"       * Leader key is set as space :)
"       * 

" Custom leader key configurations:
"

" Sections:
"       * @PLUGIN_MANAGER_AUTO_INSTALL  
"       * @PLUGINS
"       * @SESSION_MANAGEMENT
"       * @SPLIT_NAVIGATION
"       * @SPLIT_RESIZE
"       * @SPLIT_CREATION
" (please search by @SECTION_NAME to navigate .vimrc)

" @PLUGIN_MANAGER_AUTO_INSTALL
" vim-plug auto installation as suggested here
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" (please do not assume this command will work automatically when sourcing
" this .vimrc - if you are still experiencing problems installing plugins,
" please install vim-plug manually by following the instructions here
" https://github.com/junegunn/vim-plug)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" @PLUGINS
" This vim configuration uses vim-plug as its plugin manager - please visit
" https://github.com/junegunn/vim-plug in order to install the plugin manager.
" After installing the plugin manager, please run the :PlugInstall command.
call plug#begin('~/.vim/plugged')

" Theme and appearance plugins
Plug 'morhetz/gruvbox'
Plug 'kamykn/spelunker.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'pangloss/vim-javascript'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

Plug 'honza/vim-snippets'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/vim-emoji'

call plug#end()

" @SESSION_MANAGEMENT
let g:current_session_name = 'LATEST_SESSION'
let g:latest_session_name = 'LATEST_SESSION'
let g:current_session_path = '~/.vim/sessions/' . g:current_session_name . '.vim'
let g:latest_session_path = '~/.vim/sessions/' . g:latest_session_name . '.vim'

function SaveSession(name)
    if (a:name ==# '')
        execute 'mksession! ' . g:latest_session_path
        execute 'mksession! ' . g:current_session_path
        redraw!
        echo '(CURRENT_SESSION_SAVED) Updated LATEST_SESSION, and saved current session to ' . g:current_session_path
        return 'CURRENT_SESSION_SAVED'
    endif
    let l:path = '~/.vim/sessions/' . a:name . '.vim'
    if filereadable(l:path)
        let l:overwrite = confirm('A session by that name already exists, do you wish to overwrite it?', "&Yes\n&No", 2)
        if (l:overwrite == 1)
            let g:current_session_name = a:name
            let g:current_session_path = '~/.vim/sessions/' . g:current_session_name . '.vim'
            execute 'mksession! ' . g:latest_session_path
            execute 'mksession! ' . g:current_session_path
            redraw!
            echo '(SESSION_OVERWRITE) Updated LATEST_SESSION, and overwritten session saved at ' . g:current_session_path
            return 'SESSION_OVERWRITE'
        else
            execute 'mksession! ' . g:latest_session_path
            redraw!
            echo '(SESSION_OVERWRITE_BLOCKED) Updated LATEST_SESSION, but did not save unique session, as a session by the specified name already exists'
            return 'SESSION_OVERWRITE_BLOCKED'
        endif
    else
        let g:current_session_name = a:name
        let g:current_session_path = '~/.vim/sessions/' . g:current_session_name . '.vim'
        execute 'mksession! ' . g:latest_session_path
        execute 'mksession! ' . g:current_session_path
        redraw!
        echo '(NEW_SESSION_CREATED) Updated LATEST_SESSION, and saved current session to ' . g:current_session_path
        return 'NEW_SESSION_CREATED'
    endif
endfunction

function FetchSession(name)
    if (a:name ==# '')
        execute ':source ' . g:latest_session_path
        redraw!
        echo '(LATEST_SESSION_LOADED) Loaded session from ' . g:latest_session_path
        return 'LATEST_SESSION_LOADED'
    endif
    let l:path = '~/.vim/sessions/' . a:name . '.vim'
    if filereadable(l:path)
        let g:current_session_name = a:name
        let g:current_session_path = '~/.vim/sessions/' . g:current_session_name . '.vim'
        execute ':source ' . l:path
        redraw!
        echo '(REQUESTED_SESSION_LOADED) Updated global session name, and loaded session from ' . l:path
        return 'REQUESTED_SESSION_LOADED'
    else
        let l:option = confirm('A session by that name does NOT exist, do you wish to create it?', "&Yes\n&No\nLoad &Latest Session", 1)
        if (l:option == 1)
            call SaveSession(a:name)
        elseif (l:option == 2)
            redraw!
            echo '(NO_SESSION_LOADED) No was session loaded'
            return 'NO_SESSION_LOADED'
        else
            execute ':source ' . g:latest_session_path
            redraw!
            echo '(LATEST_SESSION_LOADED) Loaded session from ' . g:latest_session_path
            return 'LATEST_SESSION_LOADED'
        endif
    endif
endfunction

function QuitWithSession(name, force, confirmation)
    if (split(toupper(a:confirmation),'')[0]==#'Y')
        if (a:name!=#'')
            let l:path='~/.vim/sessions/' . a:name . '.vim'
            execute 'mksession! ' . l:path
        endif
        if force
            execute 'qa!'
        endif
        execute 'wa' 
        execute 'qa'
    endif
endfunction

function! ForceQuitWithSession(name)
    let l:path='~/.vim/sessions/' . a:name . '.vim'
    echo l:path
    execute 'wa' 
    execute 'mksession ' . l:path
    execute 'qa'
endfunction

function! ForceQuit(confirmation)
    let l:path='~/.vim/sessions/' . a:name . '.vim'
    echo l:path
    execute 'wa' 
    execute 'mksession ' . l:path
    execute 'qa'
endfunction

syntax on

set noshowmatch
set relativenumber
set nohlsearch
set hidden




set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set smartcase
set noswapfile
set nobackup

set incsearch
set termguicolors
set scrolloff=8
set encoding=utf-8

set spelllang=en
set spellfile=~/.vim/spell/en.utf-8.add
set nospell

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


let g:gruvbox_contrast_dark = 'hard'
let g:indent_guides_enable_on_vim_startup = 1

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1

let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25

" set leader key to space :)
let mapleader=' '

" @SPLIT_NAVIGATION 
nnoremap <silent> <leader>h :wincmd h<cr>
nnoremap <silent> <leader>j :wincmd j<cr>
nnoremap <silent> <leader>k :wincmd k<cr>
nnoremap <silent> <leader>l :wincmd l<cr>
nnoremap <silent> <up> :wincmd k<cr>
nnoremap <silent> <down> :wincmd j<cr>
nnoremap <silent> <right> :wincmd l<cr>
nnoremap <silent> <left> :wincmd h<cr>

nnoremap <leader>u :UndotreeShow<cr>

nnoremap <c-h> <c-d>
nnoremap <c-j> <c-e>
nnoremap <c-k> <c-y>
nnoremap <c-l> <c-u>


nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<cr>
nnoremap <leader>ps :Rg<space>
nnoremap <C-p> :GFiles<cr>
nnoremap <leader>pf :Files<cr>

" @SPLIT_RESIZE
nnoremap <silent> <leader>re :wincmd =<cr>
nnoremap <leader>r] :vertical resize +
nnoremap <leader>r[ :vertical resize -
nnoremap <leader>r :vertical resize<space>
nnoremap <leader>R} :resize +
nnoremap <leader>R{ :resize -
nnoremap <leader>R :resize<space>
nnoremap <silent> <c-up> :resize +5<cr>
nnoremap <silent> <c-down> :resize -5<cr>
nnoremap <silent> <c-right> :vertical resize +5<cr>
nnoremap <silent> <c-left> :vertical resize -5<cr>

" @SPLIT_CREATION
nnoremap <silent> <leader>w :vsplit<cr>
nnoremap <silent> <leader>W :split<cr>
nnoremap <silent> <leader>ww :vsplit <bar> :wincmd l<cr>
nnoremap <silent> <leader>WW :split <bar> :wincmd j<cr>
nnoremap <leader>wr :vsplit <bar> :vertical resize<space>
nnoremap <leader>WR :split <bar> :resize<space>
nnoremap <leader>wwr :vsplit <bar> :wincmd l <bar> :vertical resize<space>
nnoremap <leader>WWR :split <bar> :wincmd j <bar> :resize<space>

"
nnoremap <leader><c-e> :e /mnt/d/programming/
nnoremap <leader>e :vsplit /mnt/d/programming/
nnoremap <leader>E :split /mnt/d/programming/
nnoremap <leader>ee :vsplit <bar> :wincmd l <bar> :e /mnt/d/programming/
nnoremap <leader>EE :split <bar> :wincmd j <bar> :e /mnt/d/programming/


" vim session management to ensure that sessions are always directed to the
" .vim subdirectory in the mounted directory, allowing for sessions to 
" persist between docker instances
nnoremap <leader>s :call SaveSession('')<cr>
nnoremap <leader>ss :call SaveSession(input('Please enter a name to save this session as (leave blank to save to current session): '))<cr>
nnoremap <leader>S :call FetchSession('')<cr>
nnoremap <leader>SS :call FetchSession(input('Please enter the name of a session to fetch (leave blank to fetch the latest session): '))<cr>

" quit all stuff here with session aid
" nnoremap <leader>q :wa <bar> :mksession ~/.vim/sessions/ <bar> :qa <left>
nnoremap <silent> <leader>q :call QuitWithSession('latest')<cr>
nnoremap <leader>qq :call QuitWithSession(input('Please enter a session name... '))<cr>
nnoremap <leader>Q :call ForceQuitWithSession('latest')<cr>
nnoremap <leader>QQ :call ForceQuitWithSession(input('Please enter a session name... '))<cr>
nnoremap <silent> <leader><c-q> :wa <bar> :qa<cr>
nnoremap <leader><c-Q> :call ForceQuit(input('Are you sure you wish to force quit (unsaved data may be lost)? [y/n] '))<cr>


" point vim undo directory to .vim subdirectory in the mounted directory, 
" allowing for undo history to persist between docker instances
set undodir=~/.vim/undodir
set undofile

" disable all error bell sounds etc. so that vim makes no annoying sound!
set belloff=all

"
set timeoutlen=500

set cmdheight=1

