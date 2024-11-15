set nocompatible

" settings
set number				                    " numbers on side
set relativenumber			                " numbers are relative to cursor
set cursorline                              " highlight line on cursor

set showmatch                               " do not show matching brackets by flickering
set incsearch                               " shows the match while typing
set hlsearch                                " highlight found searches
set ignorecase                              " search case insensitive...
set smartcase                               " ... but not when search pattern contains upper case characters

set tabstop=4                               " use x spaces for tabs
set shiftwidth=4                            " use x spaces for shifts
set softtabstop=4                           " use x spaces for tabs
set expandtab                               " use space instead of tabs
set nowrap                                  " don't word wrap
set autoindent                              " try and figure out indedentation when possible

set clipboard=unnamedplus		            " system clipboard support
set nobackup                                " do not save backup files
set scrolloff=10                            " do not scroll below/above x lines
set autoread                                " reload changed files automatically
au FocusGained,BufEnter * silent! checktime " needed for above

" binds
inoremap jj <Esc>

" theme
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
syntax on

