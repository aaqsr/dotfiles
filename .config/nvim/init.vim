"  ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄
" ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█
"  ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄
"   ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"    ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"    ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"    ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒
"      ░░   ▒ ░░      ░     ░░   ░ ░
"       ░   ░         ░      ░     ░ ░
"      ░                           ░

"    / _` |/ _` |
" ~ | (_| | (_| |
"    \__,_|\__,_|


" ----------------------- LEADERS -----------------------
let mapleader =" "
let maplocalleader = "\\"
"Note on how this just means that maplocalleader is just a single \ and not \\


" ----------------------- PLUGINS via VIM PLUG -----------------------
call plug#begin('~/.vim/plugged')

"Displays colours (like #FFFFFF) as colours
Plug 'ap/vim-css-color'

"LaTeX plugin
Plug 'lervag/vimtex'

"sxhkd syntax highlighting
Plug 'kovetskiy/sxhkd-vim'

"Bracket pair colouriser
Plug 'luochen1990/rainbow'

"Comment lines with leader + '
Plug 'tpope/vim-commentary'

"Center zen mode
Plug 'junegunn/goyo.vim'

"Format on <F4>
Plug 'chiel92/vim-autoformat'

"The bar at the bottom
Plug 'vim-airline/vim-airline'

"pywal colourscheme support
Plug 'dylanaraps/wal.vim'

"COC (autocomplete)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Discord presence cause why not
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}

call plug#end()


" ----------------------- GENERAL MISC FOR CONVENIENCE -----------------------
" Set Numbers so that they are hybrid in normal mode and switch to absolute in insert more
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Fix/eliminate tabs
set softtabstop=4
set smarttab
set cindent
set tabstop=4
set shiftwidth=4
set expandtab

" Hide a buffer when a new one is opened on top instead of closing
set hidden

" Enable smartcase when finding
set ignorecase
set smartcase

" Enable the mouse for scrolling faster and clicking and highlighting
set mouse=a

" Use system clipboard instead of registers (sorry xxx_pro_vim_users_xxx)
set clipboard+=unnamedplus

" Writes out the replace all command
nnoremap <leader>r :%s//g<Left><Left>

" Save file as sudo when no sudo permissions
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" j/k will move virtual lines (lines that wrap) instead of having to do gj/gk
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Set spelling language
autocmd FileType tex,latex,markdown setlocal spell spelllang=en_gb


" ----------------------- THEME -----------------------
" Highlighting for code
syntax on

" Get rid of the annoying bell
set belloff=all

" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
" set termguicolors

" Set theme
colorscheme wal

" Airline
" let g:airline = { 'colorscheme': 'dark' }
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#formatter = 'default'
" set background=dark

" Airline displays the mode so we don't need to show the mode
set noshowmode

" Make brackets coloured
let g:rainbow_active = 1

" Highlights the current line you are on
" set cursorline
" highlight CursorLine guibg=#191919


" ----------------------- GOYO -----------------------
let g:goyo_width=100

" Shortcut enable goyo by <leader>z
map <leader>z :Goyo \| set linebreak<CR>


" ----------------------- DISCORD PRESENSCE -----------------------
let g:discord_activate_on_enter=1

" Shortcut update discord presence by <leader><F2>
map <leader><F2> :DiscordUpdatePresence <CR>

"Post Startup
autocmd VimEnter * DiscordUpdatePresence


" ----------------------- VIMTEX -----------------------
"For vimtex's copilation script
"for adding remote capabilities
let g:vimtex_compiler_progname = 'nvr'
"start server
if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif
"To get rid of vimtex thinking it's plaintex not tex
let g:tex_flavor = 'latex'
"To change default pdf viewer for vimtex compile:
let g:vimtex_view_method = 'zathura'
"let g:vimtex_complete_img_use_tail = 1
"let g:vimtex_fold_enabled = 1
"let g:vimtex_format_enabled = 1
" let g:vimtex_quickfix_mode=0
"To hide latex doe unless you on that line to make it better looking
" set conceallevel=1
" let g:tex_conceal='abdmg'

"Make sure the correct extension is used for latex files
autocmd BufRead,BufNewFile *.tex set filetype=tex


" ----------------------- SPLITS -----------------------
" Splits open to the right and bottom instead of left and top
set splitbelow splitright

" Shortcut split opening
nnoremap <leader>h :split<Space> \| set linebreak<CR>
nnoremap <leader>v :vsplit<Space> \| set linebreak<CR>

" Shortcut split navigation
" Instead of having to do control w then h j k l, you can just do control h j k l
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


"Key bindings

" ----------------------- COC ACTIONS -----------------------
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
endfunction

" Shortcut open COC menu by <leader>a
map <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>

" Use tab to switch between coc snippet placeholders
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

let g:coc_snippet_next = '<tab>'

"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"COC (autocomplete) plugins
let g:coc_global_extensions = [
            \ 'coc-snippets',
            \ 'coc-pairs',
            \ 'coc-spell-checker',
            \ 'coc-json',
            \ 'coc-actions',
            \ ]
"Notes on how to use:
"Do ':CocCommand snippets.editSnippets' to add custom snippets


" ----------------------- PRETTIFIER AND COMMENTER -----------------------
"Configuring path to prettiers/formatters
let g:formatterpath = ['/Users/apple/Latex_prettier/latexindent.pl:']
"to add any other language support go to https://vimawesome.com/plugin/vim-autoformat

"To format a file
noremap <F4> :Autoformat<CR>

"To comment a line
map <leader>' gcc<CR>


" ----------------------- EXPERIMENTAL -----------------------
"cntrl f to insert figure by opening inkscape (from https://github.com/gillescastel/inkscape-figures)
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

" Vertically center document when entering insert mode
" autocmd InsertEnter * norm zz

"TYPEWRITER MODE TEST (NO WORK)
" map <leader>t zz \| set scrolloff=999
" map <leader>T :set scrolloff=0 \| set linebreak<CR>
