set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

"Plug 
call plug#begin('~/.vim/plugged')

"THEME : hzchirs/vim-material on github 
Plug 'itchyny/lightline.vim'
"Plug 'kaicataldo/material.vim'
Plug 'hzchirs/vim-material'

"COC (autocomplete)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"General misc
"Set Numbers
set relativenumber
"highlighting for code
syntax on
"Get rid of the annoying bell
set belloff=all

"THEME
" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif
let g:lightline = { 'colorscheme': 'material' }
"let g:material_terminal_italics = 1
"let g:material_theme_style = 'ocean'
"colorscheme material
"EDIT: Now using hzchirs/vim-material
let g:material_style='oceanic'
set background=dark
colorscheme vim-material
"Airline displays the mode so we don't need to show the mode
set noshowmode

"Key bindings

"For coc-actions
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@


"COC (autocomplete) plugins
let g:coc_global_extensions = [
  \ 'coc-snippets', 
  \ 'coc-pairs', 
  \ 'coc-spell-checker',
  \ 'coc-json', 
  \ ]
"Notes on how to use:
"Do ':CocCommand snippets.editSnippets' to add custom snippets
