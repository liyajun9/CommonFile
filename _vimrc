source $VIMRUNTIME/vimrc_example.vim

"used for differing two or more buffers
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
set diffexpr=MyDiff()

""""""""""""""""""""""""""""""""Character Set"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"input charset
set fileencodings=utf-8,gbk,gb2312,ucs-2le,ucs-2,enu-cn,cp936,gb18030,latin1,iso-8859-2
"output charset
set termencoding=utf-8
"buffer/registers/scripts charset
set encoding=utf-8

""""""""""""""""""""""""""""""Basic Settings"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set nu
set showmode
set showcmd
set laststatus=2
set ruler
set mouse=a
"set mouse=v
filetype on
filetype indent on
set guifont=Courier_new:h11:b:cDEFAULT
set guifont=Consolas:h11
colorscheme desert
set backupdir=D:\appData\Vim\filebackup
set directory=D:\appData\Vim\filebackup
set undodir=D:\appData\Vim\filebackup
set noswapfile
set undofile
set autochdir
"set listchars=tab:»■,trail:■
set listchars=trail:■
set list

""""""""""""""""""""""""""""""indent Settings"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab

""""""""""""""""""""""""""""""search Settings"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmatch
set hlsearch
set ignorecase

""""""""""""""""""""""""""""""search Settings"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pastetoggle=<F5>
autocmd BufWritePost $MYVIMRC source $MYVIMRC

""""""""""""""""""""""""""""""search Settings"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden

""""""""""""""""""""""""""""""key mapping Settings"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

""""""""""""""""""""""""""""""visual star search"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('g:loaded_visualstar')
  finish
endif
let g:loaded_visualstar = 1

let s:save_cpo = &cpo
set cpo&vim


function! s:search(type, g)
  let s:count = v:count1 . a:type
  let reg = '"'
  let [save_reg, save_type] = [getreg(reg), getregtype(reg)]
  normal! gv""y
  let text = @"
  call setreg(reg, save_reg, save_type)

  let [pre, post] = ['', '']
  if !a:g
    let head = matchstr(text, '^.')
    let is_head_multibyte = 1 < len(head)
    let [l, col] = getpos("'<")[1 : 2]
    let line = getline(l)
    let before = line[: col - 2]
    let outer = matchstr(before, '.$')
    if text =~# '^\k' && ((!empty(outer) && len(outer) != len(head)) ||
    \   (!is_head_multibyte && (col == 1 || before !~# '\k$')))
      let pre = '\<'
    endif

    let tail = matchstr(text, '.$')
    let is_tail_multibyte = 1 < len(tail)
    let [l, col] = getpos("'>")[1 : 2]
    let col += len(tail) - 1
    let line = getline(l)
    let after = line[col :]
    let outer = matchstr(after, '^.')
    if text =~# '\k$' && ((!empty(outer) && len(outer) != len(tail)) ||
    \   (!is_tail_multibyte && (col == len(line) || after !~# '^\k')))
      let post = '\>'
    endif
  endif

  let text = substitute(escape(text, '\' . a:type), "\n", '\\n', 'g')

  let @/ = '\V' . pre . text . post
  call histadd('/', @/)
endfunction

function! s:count()
  return s:count . "\<CR>"
endfunction

function! s:extra_commands()
  if exists('g:visualstar_extra_commands')
    return g:visualstar_extra_commands
  else
    return ''
  endif
endfunction


noremap <silent> <Plug>(visualstar-*) *
noremap <silent> <Plug>(visualstar-#) #
noremap <silent> <Plug>(visualstar-g*) g*
noremap <silent> <Plug>(visualstar-g#) g#

vnoremap <silent> <script> <Plug>(visualstar-*)
\        :<C-u>call <SID>search('/', 0)<CR><SID>(count)<SID>(extra_commands)
vnoremap <silent> <script> <Plug>(visualstar-#)
\        :<C-u>call <SID>search('?', 0)<CR><SID>(count)<SID>(extra_commands)
vnoremap <silent> <script> <Plug>(visualstar-g*)
\        :<C-u>call <SID>search('/', 1)<CR><SID>(count)<SID>(extra_commands)
vnoremap <silent> <script> <Plug>(visualstar-g#)
\        :<C-u>call <SID>search('?', 1)<CR><SID>(count)<SID>(extra_commands)

nnoremap <expr> <SID>(count) <SID>count()
nnoremap <expr> <SID>(extra_commands) <SID>extra_commands()


if !exists('g:visualstar_no_default_key_mappings') ||
\   !g:visualstar_no_default_key_mappings
  silent! xmap <unique> * <Plug>(visualstar-*)
  silent! xmap <unique> <kMultiply> <Plug>(visualstar-*)
  silent! xmap <unique> <S-LeftMouse> <Plug>(visualstar-*)
  silent! xmap <unique> # <Plug>(visualstar-#)
  silent! xmap <unique> g* <Plug>(visualstar-g*)
  silent! xmap <unique> g<kMultiply> <Plug>(visualstar-g*)
  silent! xmap <unique> g<S-LeftMouse> <Plug>(visualstar-g*)
  silent! xmap <unique> g# <Plug>(visualstar-g#)
endif


let &cpo = s:save_cpo
unlet s:save_cpo
