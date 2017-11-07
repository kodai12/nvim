" basic settings
set number
set cursorline
set laststatus=2
set cmdheight=2
set showmatch
set helpheight=999
set list
set whichwrap=b,s,h,l,<,>,[,],~
set scrolloff=5
set t_Co=256
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set sh=zsh

" about file management
set confirm
set hidden
set autoread
set nobackup
set noswapfile

" about search/replacement management
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set gdefault

" tab/indent setting
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

if has('autocmd')
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
  autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
endif

" command line setting
set wildmenu wildmode=list:longest,full
set history=10000

" keymapping
inoremap fd <ESC>
vnoremap fd <ESC>
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
noremap <Space>h  ^
noremap <Space>l  $
nnoremap <Space>/  *
noremap <Space>m  %

" keymapping related to plugins
map <C-e> :NERDTreeToggle<CR>

" invalidate keymapping
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

" brackets auto increment
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<ESC>i
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap " ""<Left>
inoremap "<Enter> ""<Left><CR><ESC><S-o>
inoremap ' ''<Left>
inoremap '<Enter> ''<Left><CR><ESC><S-o>

" setting quickfix
function! OpenModifiableQF()
        cw
        set modifiable
        set nowrap
endfunction

autocmd QuickfixCmdPost vimgrep call OpenModifiableQF()

" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

syntax on
let g:alduin_Shout_Dragon_Aspect = 1
colorscheme alduin

" setting QFixHowm
set runtimepath+=~/Desktop/qfixhowm-master

let QFixHowm_Key = 'g'

let howm_dir             = '~/howm'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'
" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100
" プレビューや絞り込みをQuickFix/ロケーションリストの両方で有効化(デフォルト:2)
let QFixWin_EnableMode = 1

" gitgutter keybind
nmap <silent> <SPACE>gk <Plug>GitGutterPrevHunkzz
nmap <silent> <SPACE>gj <Plug>GitGutterNextHunkzz
nmap <silent> <SPACE>gp <Plug>GitGutterPreviewHunk
nnoremap <silent> <SPACE>gu <Nop>
nmap <silent> <SPACE>gU <Plug>GitGutterUndoHunk
nnoremap <silent> <SPACE>ga <Nop>
nmap <silent> <SPACE>gA <Plug>GitGutterStageHunk
nnoremap <silent> <SPACE>gg :GitGutter<CR>
nnoremap <silent> <SPACE>gtt :GitGutterToggle<CR>
nnoremap <silent> <SPACE>gts :GitGutterSignsToggle<CR>
nnoremap <silent> <SPACE>gtl :GitGutterLineHighlightsToggle<CR>
