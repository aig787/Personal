set nocompatible              " be iMproved
filetype off                  " required!
set number
syntax on
nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

if $COLORTERM == 'gnome-terminal'
	set t_Co=256
endif

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-distinguished'
Bundle 'nanotech/jellybeans.vim'
set background=dark
colorscheme jellybeans
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non-GitHub repos
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'git://github.com/xuhdev/SingleCompile.git'
Bundle 'git://github.com/davidhalter/jedi-vim'
" Git repos on your local machine (i.e. when working on your own plugin)



filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
