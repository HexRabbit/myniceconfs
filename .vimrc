" Setting some decent VIM settings for programming
set mouse=n
set number
set smarttab
set tabstop=4
set smartindent
set expandtab shiftwidth=2 softtabstop=2
set list listchars=tab:\¦\ |
autocmd FileType css setlocal sw=1 ts=1 nonumber
autocmd FileType python,solidity setlocal expandtab sw=4 softtabstop=4
autocmd BufNewFile,BufRead *.pug set syntax=pug " solve vim-pug's syntax bug
autocmd BufNewFile,BufRead *.sol set filetype=solidity
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
"Plugin 'Yggdroot/indentLine'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'nvie/vim-flake8'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'tpope/vim-sensible'
Plugin 'posva/vim-vue'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomasr/molokai'
Plugin 'rust-lang/rust.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'pangloss/vim-javascript'
Plugin 'Vimjas/vim-python-pep8-indent' " for using 'cc' back to the indented place
Plugin 'digitaltoad/vim-pug'
Plugin 'dNitro/vim-pug-complete'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'tomlion/vim-solidity'
Plugin 'majutsushi/tagbar'
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

" vim-jsx settings
let g:jsx_ext_required = 0  " Allow JSX in normal JS files
""""

" vim-python-pep8-indent settings
let g:pymode_indent = 0
let g:python_pep8_indent_multiline_string = 1
""""

" ctags settings
" ref: https://vim.fandom.com/wiki/Single_tags_file_for_a_source_tree
set tags=tags 
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

" ycm settings
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_autoclose_preview_window_after_completion = 1
""""

" custom bracket-completion
function! FuncFin()
  call feedkeys("o}\<ESC>=%$")
endfunction

function! CharMove()
  let chr=''
  echo "custom bracket-completion"
  if getchar(1)
    let chr = getchar()
    call feedkeys(nr2char(chr))
  endif
  call feedkeys("\<F2>")
endfunction

imap @{ {<ESC>j<F2>
nmap <silent> <F2><TAB> :call FuncFin()<CR>
nmap <silent> <F2> :call CharMove()<CR>
""""

" Comment or uncomment lines from mark a to mark b.
function! CommentMark(docomment, a, b)
  if !exists('b:comment')
    let b:comment = CommentStr() . ' '
  endif
  if a:docomment
    exe "normal! '" . a:a . "_\<C-V>'" . a:b . 'I' . b:comment
  else
    exe "'".a:a.",'".a:b . 's/^\(\s*\)' . escape(b:comment,'/') . '/\1/e'
  endif
endfunction

" Comment lines in marks set by g@ operator.
function! DoCommentOp(type)
  call CommentMark(1, '[', ']')
endfunction

" Uncomment lines in marks set by g@ operator.
function! UnCommentOp(type)
  call CommentMark(0, '[', ']')
endfunction

" Return string used to comment line for current filetype.
function! CommentStr()
  if &ft == 'c' || &ft == 'cpp' || &ft == 'java' || &ft == 'javascript'
    return '//'
  elseif &ft == 'vim'
    return '"'
  elseif &ft == 'python' || &ft == 'perl' || &ft == 'sh' || &ft == 'R'
    return '#'
  elseif &ft == 'lisp'
    return ';'
  endif
  return ''
endfunction
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
au FileType h,c,hpp,cpp,java,css,javascript inoremap <buffer> for<TAB> for (int i = 0; i < ; ++i) {<CR><END><CR>}<ESC><UP><UP>2fi
au FileType h,c,hpp,cpp,java,css,javascript inoremap <buffer> fori for (int i = 0; i < ; ++i) {<CR><END><CR>}<ESC><UP><UP>2f;
au FileType h,c,hpp,cpp,java,css,javascript inoremap <buffer> forj for (int j = 0; j < ; ++j) {<CR><END><CR>}<ESC><UP><UP>2f;
au FileType h,c,hpp,cpp,java,css,javascript inoremap <buffer> fork for (int k = 0; k < ; ++k) {<CR><END><CR>}<ESC><UP><UP>2f;
""""

" hot key
vnoremap <C-y> "+y
nnoremap <C-p> "+p
inoremap jk <ESC>
cnoremap jk <ESC>
inoremap Jk <ESC>
cnoremap Jk <ESC>
nnoremap `` ``zz
nnoremap <SPACE> :w<CR>
nnoremap <leader>ev :vsplit ~/.vimrc<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>
nnoremap <F6> :TlistToggle<CR>
map <silent> <leader>p :setlocal nopaste!<CR>
nnoremap <F9> :NERDTreeToggle<CR>
nnoremap <F12> :TagbarToggle<CR>
au FileType python nmap <buffer> <F8> :call Flake8()<CR>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
nnoremap <Leader>c <Esc>:set opfunc=DoCommentOp<CR>g@
nnoremap <Leader>C <Esc>:set opfunc=UnCommentOp<CR>g@
vnoremap <Leader>c <Esc>:call CommentMark(1,'<','>')<CR>
vnoremap <Leader>C <Esc>:call CommentMark(0,'<','>')<CR>
""""
