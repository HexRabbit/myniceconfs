" Setting some decent VIM settings for programming
set mouse=n
set number
set smarttab
set smartindent
set expandtab shiftwidth=2 softtabstop=2
set list listchars=tab:\¦\ |
autocmd FileType css setlocal sw=1 ts=1 nonumber
autocmd FileType python setlocal expandtab sw=4 softtabstop=4
set autoindent                  " set auto-indenting on for programming
set showcmd                     " show the typing command
set showmatch                   " automatically show matching brackets.
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set background=dark             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
set nocompatible                " be iMproved
let mapleader="9"               " the <leader> key.
syntax enable                   " turn syntax highlighting on by default

" set the runtime path to include Vundle and initialize
filetype on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'nvie/vim-flake8'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'tpope/vim-sensible'
Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomasr/molokai'
Plugin 'rust-lang/rust.vim'
Plugin 'mxw/vim-jsx'
call vundle#end()
filetype plugin indent on
""""

" Show syntax highlighting groups for word under cursor
"nmap <C-S-P> :call <SID>SynStack()<CR>
"function! <SID>SynStack()
"  if !exists("*synstack")
"    return
"  endif
"  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
"endfunc
""""

" solarized theme settings
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_visibility="low"
colorscheme molokai
""""


" airline settings
let g:airline_theme='laederon'
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
""""

" emmet settings
let g:user_emmet_install_global=0
autocmd FileType html,css,htmljinja EmmetInstall
let g:user_emmet_leader_key='<TAB>'
""""

" vim-javascript syntax settings
let g:javascript_plugin_jsdoc=1
""""

" vim-jsx settings
let g:jsx_ext_required = 0
""""

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
""""

" remove trailing whitespace when type :w on normal mode
autocmd BufWritePre *.{h,c,hpp,cpp,java,py,html,css,js} :%s/\s\+$//e
""""

" auto-arrange the whole coding indentation field after reading the file into the buffer
"autocmd BufReadPost *.{h,c,hpp,cpp,java} :normal gg=G
""""

" bracket-completion
au FileType html,htmljinja inoremap <buffer> {% {%  %}<LEFT><LEFT><LEFT>
au FileType html,htmljinja inoremap <buffer> {{ {{  }}<LEFT><LEFT><LEFT>
au FileType javascript inoremap <buffer> ({<CR> ({<CR><END><CR>})<UP><END>
au FileType h,c,hpp,cpp,java,css,javascript,rust inoremap <buffer> {<CR> {<CR><END><CR>}<UP><END>
au FileType h,c,hpp,cpp,java,javascript,rust inoremap <buffer> {; {<CR><END><CR>};<UP><END>
au FileType h,c,hpp,cpp,java,css,javascript,rust inoremap <buffer> {<SPACE> {<SPACE><SPACE>}<LEFT><LEFT>
au FileType h,c,hpp,cpp,java,css,javascript,rust inoremap <buffer> {<END> {<SPACE><END><SPACE>}
"au FileType h,c,hpp,cpp,java,css,javascript inoremap <buffer> < <<END>><LEFT>  
au FileType h,c,hpp,cpp,java,css,javascript inoremap <buffer> for<TAB> for(int i=0; i<; ++i) {<CR><CR><END><CR>}<ESC><UP><UP><UP>2fi
""""

" hot key
vnoremap <C-y> "+y
nnoremap <C-p> "+p
inoremap jk <ESC>
cnoremap jk <ESC>
nnoremap `` ``zz
nnoremap <SPACE> :w<CR>
nnoremap <leader>ev :vsplit ~/.vimrc<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>
nnoremap <F6> :TlistToggle<CR>
map <silent> <leader>p :setlocal nopaste!<CR>
nnoremap <F9> :NERDTreeToggle<CR>
au FileType python nmap <buffer> <F8> :call Flake8()<CR>
""""
