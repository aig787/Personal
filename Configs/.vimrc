set nocompatible              " be iMproved
filetype off                  " required!
set number
syntax on
nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
if $COLORTERM == 'gnome-terminal'
	set t_Co=256
endif

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-rails.git'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'nanotech/jellybeans.vim'
set background=dark
colorscheme jellybeans
" vim-scripts repos
Plugin 'L9'
Plugin 'FuzzyFinder'
" non-GitHub repos
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'git://github.com/xuhdev/SingleCompile.git'
Plugin 'git://github.com/davidhalter/jedi-vim'
" Git repos on your local machine (i.e. when working on your own plugin)



filetype plugin indent on     " required!
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install (update) bundles
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
