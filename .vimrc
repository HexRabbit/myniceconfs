" Setting some decent VIM settings for programming
set encoding=utf-8
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
set mouse=r                     " disable mouse scroll
set nocompatible                " be iMproved
let mapleader="9"               " the <leader> key.  
syntax enable                   " turn syntax highlighting on by default

" set the runtime path to include Vundle and initialize
filetype on
set rtp+=~/.vim/autoload/plug.vim
call plug#begin()
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
"Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'nvie/vim-flake8'
Plug 'mitsuhiko/vim-jinja'
Plug 'tpope/vim-sensible'
Plug 'posva/vim-vue'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomasr/molokai'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'Vimjas/vim-python-pep8-indent' " for using 'cc' back to the indented place
Plug 'digitaltoad/vim-pug'
Plug 'dNitro/vim-pug-complete'
Plug 'neovimhaskell/haskell-vim'
Plug 'tomlion/vim-solidity'
Plug 'majutsushi/tagbar'
"Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 ./install.py --all' }
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'mattn/vim-lsp-settings' "not work on macos
call plug#end()
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

" if executable('pyls')
"     " pip install python-language-server
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'allowlist': ['python'],
"         \ })
" endif
" 
" function! s:on_lsp_buffer_enabled() abort
"     setlocal omnifunc=lsp#complete
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"     nmap <buffer> gd <plug>(lsp-definition)
"     nmap <buffer> gr <plug>(lsp-references)
"     nmap <buffer> gi <plug>(lsp-implementation)
"     nmap <buffer> gt <plug>(lsp-type-definition)
"     nmap <buffer> <leader>rn <plug>(lsp-rename)
"     nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)
"     
"     " refer to doc to add more commands
" endfunction
" 
" augroup lsp_install
"     au!
"     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END

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
let g:ycm_server_python_interpreter='/usr/local/bin/python3'
"let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_autoclose_preview_window_after_completion = 1
""""

" ranger.vim setting
set shell=bash

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

" Ranger.vim settings

" bracket-completion
au FileType html,htmljinja inoremap <buffer> {% {%  %}<LEFT><LEFT><LEFT>
au FileType html,htmljinja inoremap <buffer> {{ {{  }}<LEFT><LEFT><LEFT>
au FileType javascript inoremap <buffer> ({<CR> ({<CR><END><CR>})<UP><END>
au FileType h,c,hpp,cpp,java,css,javascript,rust,python inoremap <buffer> {<CR> {<CR><END><CR>}<UP><END>
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
