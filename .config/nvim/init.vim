"
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


" ----------------------- PRE-PLUGIN CONFIG -----------------------

"" Kills ALE's built in lang server, to prevent conflict with coc.nvim
let g:ale_disable_lsp = 1


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

"Comment lines with leader + /
Plug 'tpope/vim-commentary'

"Center zen mode
Plug 'junegunn/goyo.vim'

"Format on <F4>
Plug 'chiel92/vim-autoformat'
" TODO: Is this even useful?

"The bar at the bottom
Plug 'vim-airline/vim-airline'

"pywal colourscheme support
Plug 'dylanaraps/wal.vim'

"Tender colourscheme
Plug 'jacoborus/tender.vim'

"Vscode dark colourscheme
Plug 'tomasiser/vim-code-dark'

"One dark pro colourscheme
Plug 'joshdick/onedark.vim'

"vim dark colourscheme
Plug 'rakr/vim-one'

"gruvbox colourscheme
Plug 'morhetz/gruvbox'

"embark colourscheme
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }

"everblush colourscheme
Plug 'mangeshrex/everblush.vim'

"onehalf colourscheme
Plug 'sonph/onehalf', { 'rtp': 'vim' }

"COC (autocomplete)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Discord presence cause why not
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}

"JSX and TSX colours
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

"Auto Complete XML and HTML tags in .html and .jsx files
Plug 'alvan/vim-closetag'

"Markdown preview for live previewing markdown in browser
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

"C/C++ syntax highlighting following the guide here: https://chmanie.com/post/2020/07/17/modern-c-development-in-neovim/
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'octol/vim-cpp-enhanced-highlight'
"plus linting
" Plug 'vim-syntastic/syntastic'
" TODO: Update the removal of this as syntastic is deprecated
" TODO: Find replacement
Plug 'rhysd/vim-clang-format'

"Racket plugins
Plug 'benknoble/vim-racket'

"A general REPL plugin
Plug 'rhysd/reply.vim', { 'on': ['Repl', 'ReplAuto'] }

"For Rust development
Plug 'rust-lang/rust.vim'

"ALE for extra linting with coc.nvim
Plug 'dense-analysis/ale'

" Dev Icons - Load this last
Plug 'ryanoasis/vim-devicons'

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

" Set encoding to utf-8
set encoding=UTF-8

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

" wrap lines properly
set wrap
set linebreak

" j/k will move virtual lines (lines that wrap) instead of having to do gj/gk
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Set spelling language
autocmd FileType tex,latex,markdown setlocal spell spelllang=en_gb

" Diables highlighting after a search is over with leader n
map <leader>n :se nohlsearch<CR>


" ----------------------- THEME -----------------------
" Highlighting for code
syntax on
" something rust.vim made me do
filetype plugin indent on

" Get rid of the annoying bell
set belloff=all

" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" Set 256 colour for terminals
set t_Co=256
set t_ut=

" for true color support
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Set theme
" colorscheme wal
" colorscheme tender
" colorscheme codedark
" colorscheme onedark
" colorscheme gruvbox
" colorscheme one
" colorscheme embark
colorscheme onehalfdark

" Remove the background that comes with colourscheme for transparency
hi Normal guibg=NONE ctermbg=NONE

" Airline
" let g:airline = { 'colorscheme': 'dark' }
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#formatter = 'default'
set background=dark
" let g:airline_theme = 'codedark'
" let g:airline = { 'colorscheme': 'tender' }
" let g:airline = { 'colorscheme': 'codedark' }
" let g:airline_theme = 'gruvbox'
" let g:airline_theme='one'
let g:airline_theme='embark'

" Airline displays the mode so we don't need to show the mode
set noshowmode

" Make brackets coloured
let g:rainbow_active = 1

" Highlights the current line you are on
" set cursorline
" highlight CursorLine guibg=#191919




" ----------------------- GOYO -----------------------

if exists("g:neovide")
    set guifont=FiraCode\ Nerd\ Font:h13
endif


" ----------------------- GOYO -----------------------
let g:goyo_width=100

" Shortcut enable goyo by <leader>z
" map <leader>z :Goyo \| set linebreak<CR>
map <leader>z :Goyo<CR>


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


" ----------------------- MARKDOWN -----------------------
autocmd FileType markdown nmap <F5> :w \| :MarkdownPreview<CR>


" ----------------------- SPLITS / TABS -----------------------
" Splits open to the right and bottom instead of left and top
set splitbelow splitright

" Shortcut split opening
nnoremap <leader>h :split<Space> \| :Ex<CR>
nnoremap <leader>v :vsplit<Space> \| :Ex<CR>

" Shortcut split navigation
" Instead of having to do control w then h j k l, you can just do control h j k l
map <leader>wh <C-w>h
map <leader>wj <C-w>j
map <leader>wk <C-w>k
map <leader>wl <C-w>l

" Opens a new tab
nnoremap <leader>T :tabnew <CR>


" ----------------------- TERM -----------------------
" Opens a small terminal split
nnoremap <leader>t :10sp <CR> \| :term <CR> I

" Esc in terminal triggers normal mode
tnoremap <Esc> <C-\><C-n>

" git commands in term
    " status
tnoremap <localleader>gs <Esc>Igit status<CR>
    " commit
tnoremap <localleader>gc <Esc>Igit commit -a
    " diff
tnoremap <localleader>gd <Esc>Igit diff
    " push
tnoremap <localleader>gp <Esc>Igit push<CR>
    " pull
tnoremap <localleader>gP <Esc>Igit pull<CR>


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

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Explorer
" do space e to open the explorer
nmap <space>e :CocCommand explorer<CR>
" for opening explorer in floating win (NOT SETUP)
" nmap <space>f :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif


"COC (autocomplete) plugins
let g:coc_global_extensions = [
            \ 'coc-snippets',
            \ 'coc-pairs',
            \ 'coc-spell-checker',
            \ 'coc-json',
            \ 'coc-actions',
            \ 'coc-css',
            \ 'coc-tsserver',
            \ 'coc-html',
            \ 'coc-eslint',
            \ 'coc-python',
            \ 'coc-explorer',
            \ ]
"Notes on how to use:
"Do ':CocCommand snippets.editSnippets' to add custom snippets

" Do 'npx eslint --init' in the shell to set up this file

" ----------------------- PRETTIFIER AND COMMENTER -----------------------
"Configuring path to prettiers/formatters
let g:formatterpath = ['/Users/apple/Latex_prettier/latexindent.pl:']
"to add any other language support go to https://vimawesome.com/plugin/vim-autoformat

"To format a file
noremap <F4> :Autoformat<CR>

"To comment a line
map <leader>/ gcc
" If not supported then set 'commentstring'


" ----------------------- COMPILE ON <F5> -----------------------
" html:
autocmd FileType html nmap <F5> :w \| :!$BROWSER % <CR>



" ----------------------- Vim REPL keybinds -----------------------
"
"  If you ever want to set a max width https://github.com/rhysd/reply.vim

" Works with repl then returns to the previous window
map <localleader>rr :Repl <CR> <Esc> <C-w>p
map <localleader>rs :ReplSend <CR> <Esc> <C-w>p


" ----------------------- vim-closetag -----------------------
"  Autocomplets html, xml tags
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx,*.js,*.ts'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xml,*.xhtml,*.jsx,*.tsx,*.js,*.ts'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,jsx,tsx,ts,js'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xml,xhtml,jsx,tsx,ts,js'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
" Do not set this to <leader> > as the docs suggest as that maps <leader>
" (space) in insert mode, which makes inserting a space sluggish and slow
let g:closetag_close_shortcut = ''

" ----------------------- C/C++ Syntaxing ---------------------

" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" linting
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" to format on save
let b:ale_fix_on_save = 1



" formatting : vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1

" Either one for functions
" slower but better
let g:cpp_experimental_simple_template_highlight = 1
" faster but worse
" let g:cpp_experimental_template_highlight = 1

let g:cpp_concepts_highlight = 1


" ----------------------- RACKET -----------------------

" For Racket synstax checking
" Note:
" WARNING: THIS IS A SECURITY ISSUE AS VIM EXECS RACKET CODE ON FILE SAVE
" BE VERY CAREFUL OF RACKET SCRIPTS ONLINE
" I DIDN'T WANT TO DO THIS SO IT IS SET TO 0 FOR NOW
" NEED TO FIND A WAY TO FIX THIS

let g:syntastic_enable_racket_racket_checker = 0

" UPDATE: ACCORDING TO THIS POST https://logc.github.io/blog/2016/09/23/racket-and-vim-syntastic/
" THIS HAS BEEN FIXED AS LONG AS ONE USES THIS LINE
" But i don't trust it

" let g:syntastic_racket_racket_args="--load"

" Adds the racket executable itself as a racket checker
" let g:syntastic_racket_checkers = "racket"


" ----------------------- RUST -----------------------

" For autoformatting on save
let g:rustfmt_autosave = 1


" ----------------------- EXPERIMENTAL -----------------------
"cntrl f to insert figure by opening inkscape (from https://github.com/gillescastel/inkscape-figures)
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

" Vertically center document when entering insert mode
" autocmd InsertEnter * norm zz

"TYPEWRITER MODE TEST (NO WORK)
" map <leader>t zz \| set scrolloff=999
" map <leader>T :set scrolloff=0 <CR>

" Need to make a zen mode with goyo and line highlighting and auto scrolling and limelight hmm
" Need to set up fzf
