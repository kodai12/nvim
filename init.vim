"" basic settings
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
set guifont=Hack\ Regular\ Nerd\ Font\ Complete:h15
set fileformats=unix,dos,mac
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set sh=zsh
set clipboard+=unnamedplus
set mouse-=a
set backspace=indent,eol,start

"" about file management
set confirm
set hidden
set autoread
set nobackup
set noswapfile

"" about search/replacement management
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set gdefault

"" tab/indent setting
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
  autocmd FileType json        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType css         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scss        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sass        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType rust        setlocal sw=2 sts=2 ts=2 et
endif

"" command line setting
set wildmenu wildmode=list:longest,full
set history=10000

"" brackets completion
inoremap < <><LEFT>
inoremap <<Enter> <><Left><CR><ESC><S-o>

"" keymapping
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
noremap <Space>noh :noh<CR>
autocmd FileType python inoremap # X<C-H>#

"" invalidate keymapping
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

"" setting quickfix
function! OpenModifiableQF()
        cw
        set modifiable
        set nowrap
endfunction

autocmd QuickfixCmdPost vimgrep call OpenModifiableQF()

"" 現在のファイル名を表示する時にフルパスで表示する
nnoremap <c-g> 1<c-g>
"" ファイルを開いた時にファイルのフルパスをコマンドラインに表示
augroup EchoFilePath
  autocmd WinEnter * execute "normal! 1\<C-g>"
augroup END

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

"" setting colorsheme
filetype plugin on
syntax on
set background=dark
colorscheme iceberg
highlight Visual ctermfg=234 ctermbg=252 guifg=#161821 guibg=#c6c8d1
" ALE warningの色を調整
highlight ALEWarningSign ctermfg=226

"" setting QFixHowm
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

"" agit keymap
nmap <silent> <SPACE>av <Plug>Agit
nmap <silent> <SPACE>avf <Plug>AgitFile

"" undotree keymap
nnoremap <SPACE>udt :UndotreeToggle<CR>

"" nerdtree keymap
nnoremap [NERDTree] <Nop>
nmap <SPACE>ft [NERDTree]
nnoremap <silent> [NERDTree]t :NERDTreeToggle<CR>
nnoremap <silent> [NERDTree]f :NERDTreeFind<CR>

"" fugitive keymap
nnoremap <silent> <SPACE>gs :<C-u>Gstatus<CR>
nnoremap <silent> <SPACE>gv :<C-u>Gvdiff<CR>
nnoremap <silent> <SPACE>gB :Gblame<CR>
nnoremap <silent> <SPACE>ga :<C-u>Gwrite<CR>
nnoremap <silent> <SPACE>gC :<C-u>Gcommit-v<CR>

"" merginal keymap
nnoremap <SPACE>mt :<C-u>MerginalToggle<CR>

"" denite keymap
nnoremap <SPACE>dg :Denite grep<CR>
nnoremap <SPACE>dag :Denite -auto-preview grep<CR>
nnoremap <SPACE>dc :DeniteCursorWord grep<CR>
nnoremap <SPACE>dac :DeniteCursorWord -auto-preview grep<CR>
nnoremap <SPACE>db :Denite buffer<CR>
nnoremap <SPACE>df :DeniteProjectDir file/rec<CR>
nnoremap <SPACE>dF :Denite file_mru<CR>
nnoremap <SPACE>dy :Denite neoyank<CR>
nnoremap <SPACE>gb :Denite gitbranch<CR>
nnoremap <SPACE>gc :Denite gitchanged<CR>
nnoremap <SPACE>gl :Denite gitlog<CR>

"" nerdcommenter keymap
nmap <SPACE>cn <plug>NERDCommenterNested
nmap <SPACE>cy <plug>NERDCommenterYank
nmap <SPACE>cm <plug>NERDCommenterMinimal
nmap <SPACE>cc <plug>NERDCommenterToggle
nmap <SPACE>cs <plug>NERDCommenterSexy
nmap <SPACE>ci <plug>NERDCommenterToEOL
nmap <SPACE>cA <plug>NERDCommenterAppend
nmap <SPACE>cx <plug>NERDCommenterAltDelims

xmap <SPACE>cn <plug>NERDCommenterNested
xmap <SPACE>cy <plug>NERDCommenterYank
xmap <SPACE>cm <plug>NERDCommenterMinimal
xmap <SPACE>cc <plug>NERDCommenterToggle
xmap <SPACE>cs <plug>NERDCommenterSexy
xmap <SPACE>ci <plug>NERDCommenterToEOL
xmap <SPACE>cA <plug>NERDCommenterAppend
xmap <SPACE>cx <plug>NERDCommenterAltDelims

"" anzu settings
nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
augroup vim-anzu
  " 一定時間キー入力がないとき、ウインドウを移動したとき、タブを移動したときに
  " 検索ヒット数の表示を消去する
  autocmd!
  autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END

"" prettier setting cf. https://github.com/prettier/prettier-eslint-cli
"autocmd FileType javascript set formatprg=prettier-eslint\ --stdin
"autocmd BufWritePre *.js :normal gggqG

"" setting .vue file syntax
autocmd FileType vue syntax sync fromstart

"" ale keymap
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"" setting vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" tab setting cf.https://qiita.com/wadako111/items/755e753677dd72d8036d
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>

" tag jump keymapping
nnoremap <SPACE>tj :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <SPACE>tk :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" tagbar keymapping
nnoremap <SPACE>tb :TagbarToggle<CR>

" setting about gutentags
augroup lightline_update
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END
set statusline+=%{gutentags#statusline()}
if exists("g:plugs['vim-gutentags']")
    " config project root markers.
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
     let g:gutentags_ctags_tagfile = '.tags'
     " enable ctags and gtags
    let g:gutentags_modules = []
    if executable('ctags')
        let g:gutentags_modules += ['ctags']
    endif
    if executable('gtags-cscope') && executable('gtags')
        let g:gutentags_modules += ['gtags_cscope']
    endif
     " generate datebases in my cache directory, prevent gtags files polluting my project
    let s:vim_tags = expand('~/.cache/tags')
    if !isdirectory(s:vim_tags)
        silent! call mkdir(s:vim_tags, 'p')
    endif
     let g:gutentags_cache_dir = s:vim_tags
     " forbid gutentags adding gtags databases
    let g:gutentags_auto_add_gtags_cscope = 0
endif

" terminal settings
tnoremap <Esc> <C-\><C-n>
tnoremap fd <C-\><C-n>
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber
