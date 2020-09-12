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
set showmode
set showcmd
set laststatus=2
set ruler
set mouse=a
set mouse=v
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
"set list

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


""""""""""""""""""""""""""""""key mapping Settings"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

