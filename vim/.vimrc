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
" Note that some plugins such as neoclide require language servers to be installed
" independently (see github)
call plug#begin('~/.vim/plugged')

" Theme and appearance plugins
Plug 'morhetz/gruvbox'
Plug 'kamykn/spelunker.vim'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'pangloss/vim-javascript'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

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
set scrolloff=8
set encoding=utf-8

set spelllang=en
set spellfile=~/.vim/spell/en.utf-8.add
set nospell

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
set encoding=UTF-8

" @APPEARANCE
set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey

"let g:gruvbox_contrast_dark = 'hard'
let g:indent_guides_enable_on_vim_startup = 1

colorscheme cterm
" set background=dark
"set termguicolors
"highlight Comment ctermfg=93
"highlight Constant ctermbg=0
"highlight Normal ctermbg=0
"highlight NonText ctermbg=0
"highlight Special ctermbg=0
"highlight Cursor ctermbg=0

let g:javascript_plugin_jsdoc = 1
let g:airline_powerline_fonts = 1

"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ' '
"let g:airline_symbols.linenr = ''

" @COLORS

hi jsOperator guifg=#fb4934
hi jsTernaryIfOperator guifg=#83a598

" hi jsBraces
" hi jsBrackets
" hi jsParens
" hi jsFuncBraces
" hi js FuncParens
" hi jsClassBraces
" hi jsDot
"
" hi jsTemplateBraces
"
" hi jsObjectKey guifg=#d3869b
" hi jsVariableDef guifg=#d3869b
" hi jsObjectProp guifg=#d3869b
" hi jsFuncName
" hi js FuncArgExpression
" hi jsFunArgCommas
" hi jsClassDefinition
" hi jsGlobalObjects
" hi jsUndefined
" hi jsNull
" hi jsNan
" hi jsStorageClass (const var let)
hi jsStatement guifg=#d3869b

" @NEOCLIDE
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

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

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
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

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

