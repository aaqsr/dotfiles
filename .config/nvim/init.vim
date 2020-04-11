"Check if Vimrc exists and tries to import it
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vimrc


"TODO MAKE IT MORE ORGANISED
"ORGANISE BY PLUGIN


let mapleader =" "
let maplocalleader = "\\"
"Note on how this just means that just a single \ is localleader not \\

"Plug
call plug#begin('~/.vim/plugged')

"Displays colours (#FFFFFF) as colours
Plug 'ap/vim-css-color'

"LaTeX plugin
Plug 'lervag/vimtex'

"Bracket pair colouriser
Plug 'luochen1990/rainbow'

"Comment lines with leader + '
Plug 'tpope/vim-commentary'

"Center zen mode
Plug 'junegunn/goyo.vim'

"Format on <F4>
Plug 'chiel92/vim-autoformat'

"THEME : hzchirs/vim-material on github
"Plug 'itchyny/lightline.vim'
"The bar at the bottom
Plug 'vim-airline/vim-airline'
"Plug 'kaicataldo/material.vim'
"The actual theme
"Plug 'hzchirs/vim-material'
"Plug 'jaredgorski/spacecamp'
"Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'whatyouhide/vim-gotham'
Plug 'dylanaraps/wal.vim'

"COC (autocomplete)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Discord presence cause why not
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}

call plug#end()



"General misc
"Set Numbers so that they are hybrid in normal mode and switch to absolute in insert more
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
"highlighting for code
syntax on
"Get rid of the annoying bell
set belloff=all
set smarttab
set cindent
set tabstop=4
set shiftwidth=4
" always uses spaces instead of tab characters
set expandtab
"(DEPRECATED) for autocompletion in command mode
"set wildmode=longest,list,full
set hidden
set ignorecase
set smartcase
set mouse=a

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


"THEME
" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
" if (has('termguicolors'))
    " set termguicolors
" endif
"Configuring the line at bottom of screen
" let g:airline = { 'colorscheme': 'dark' }
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#formatter = 'default'
"let g:material_terminal_italics = 1
"let g:material_theme_style = 'ocean'
"colorscheme material
"EDIT: Now using hzchirs/vim-material
"let g:material_style='oceanic'
"set background=dark
" colorscheme gotham

colorscheme wal

"Airline displays the mode so we don't need to show the mode
set noshowmode
"Configuring Goyo
let g:goyo_width=100
"Configuring Discord presence
let g:discord_activate_on_enter=1
"Configuring path to prettiers/formatters
let g:formatterpath = ['/Users/apple/Latex_prettier/latexindent.pl:']
"to add any other language support go to https://vimawesome.com/plugin/vim-autoformat
"to make brackets coloured
let g:rainbow_active = 1


"Key bindings
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
"For coc-actions
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
endfunction
map <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
"For using tab to switch between coc snippet placeholders
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"For goyo
map <leader>z :Goyo \| set linebreak<CR>

"To update discord presence
map <leader><F2> :DiscordUpdatePresence <CR>

"To format a file
noremap <F4> :Autoformat<CR>

"To comment a line
map <leader>' gcc<CR>

"cntrl f to insert figure by opening inkscape (from https://github.com/gillescastel/inkscape-figures)
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

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

"Post Startup
autocmd VimEnter * DiscordUpdatePresence
