"PLUGINS
"Automatic vim-plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
"call plug#begin('~/.vim/plugged')
call plug#begin()
Plug 'dracula/vim',{'as':'dracula'}
Plug 'rust-lang/rust.vim'

" #############################
" Plugins programming languages
" #############################
" javascript
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'

" Initialize plugin system
call plug#end()
colorscheme dracula
syntax on

" ##########################
" Plugin Settings
" ##########################
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
  autocmd VimEnter * wincmd p
augroup END
" close if final buffer is netrw or the quickfix
augroup finalcountdown
 au!
 autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
" autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) || &buftype == 'quickfix' | q | endif
nmap - :Lexplore<cr>
"nmap - :NERDTreeToggle<cr>
augroup END
" ##########################
" General Settings 
" ##########################
" enter the current millenium
set nocompatible
set backspace=indent,eol,start

language en_US

" SYSTEM CLIPBOARD
" Use systemclipboard
set clipboard+=unnamed,unnamedplus

"" set default identation
set tabstop=4
set shiftwidth=4
set expandtab
set laststatus=2

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer


" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" SNIPPETS:
" The empty HTML file does not exist currently => just a reminder that this is possible
" more from vim without plugins https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
" Read an empty HTML template and move cursor to title
"nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them

filetype plugin indent on " enable file type detection
set autoindent

"---------------------
" Basic editing config
"---------------------
set shortmess+=I " disable startup message
set nu " number lines
set rnu " relative line numbering
set mouse+=a " enable mouse mode (scrolling, selection, etc)

" disable audible bell
set noerrorbells visualbell t_vb=
