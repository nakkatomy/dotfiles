"********** dein.vimの設定 **********
if &compatible
    set nocompatible            "Be iMproved
endif
set runtimepath+=~/.vim/bundle/dein.vim

call dein#begin(expand('~/.vim/bundle'))

"Let dein manage dein
call dein#add('Shougo/dein.vim')

"Add or remove plugins here
call dein#add('tomasr/molokai')                     "カラーテーマ
call dein#add('Shougo/neocomplete.vim')             "入力補完
call dein#add('scrooloose/nerdtree')                "ファイルをツリー表示
call dein#add('nathanaelkane/vim-indent-guides')    "インデントに色を付ける
call dein#add('tpope/vim-fugitive')                 "VimからGitコマンドを実行
call dein#add('gregsexton/gitv')                    "gitkコマンドのようなコミット履歴を専用バッファに表示
call dein#add('cohama/agit.vim')                    "Gitの差分を表示
call dein#add('itchyny/lightline.vim')              "ステータスラインの表示内容を強化
call dein#add('thinca/vim-quickrun')                "さまざまなコマンドを実行
call dein#add('tomtom/tcomment_vim')                "ファイルタイプに従ってコメント化,非コメント化
call dein#add('tpope/vim-surround')                 "選択範囲を記号やタグで囲むことや外すことができる
call dein#add('bronson/vim-trailing-whitespace')    "行末の不要なスペースを可視化
call dein#add('scrooloose/syntastic')               "シンタックスチェック
call dein#add('Shougo/neosnippet.vim')              "スニペット機能をvimに追加
call dein#add('Shougo/neosnippet-snippets')         "neosnippets用スニペット集
call dein#add('honza/vim-snippets')                 "neosnippet-snippetsに無いものを追加
call dein#add('sjl/gundo.vim')                      "Undo履歴を専用バッファに表示
call dein#add('taglist.vim')                        "ソースコードのアウトラインを表示
call dein#add('cohama/lexima.vim')                  "autoclose
call dein#add('Shougo/unite.vim')                   "任意の[候補](ファイル名やバッファ名など)から[選択]を行い,[種類]に応じた[操作](開く,削除など)を実行. []はプラグインを用いて拡張
call dein#add('Shougo/vimshell.vim')                "vimをシェルとして使用.また,unite.vimの[操作]にvimshellで実行する機能を追加
call dein#add('rking/ag.vim')                       "ag(the_silver_sercher)と連携. 高速にファイル検索可能

call dein#end()

filetype plugin indent on


"---------------------------------------------------------------------------------------------------


"********** neocompleteの設定 **********
let g:neocomplete#enable_at_startup = 1             "起動時に有効化
let g:neocomplete#enable_smart_case = 1             "大文字が入力されるまで大文字小文字の区別を無視
let g:neocomplete#sources#syntax#min_keyword_length = 3  "シンタックスをキャッシュするときの最小文字長
let g:neocomplete#auto_completion_start_length = 2  "補完を表示する最小文字数
"let g:neocomplete#max_list =                       "ポップアップメニューで表示される候補の数
"let g:neocomplete#max_keyword_width =              "width of a candidate displayed in a pop-up menu
let g:neocomplete#enable_auto_close_preview = 0     "preview windowを閉じない
AutoCmd InsertLeave * silent! pclose!

"** Define dictionary **
"let s:neoco_dicts_dir = $HOME . '/dicts'
"if isdirectory(s:neoco_dicts_dir)
"    let g:neocomplete#sources#dictionary#dictionaries = {
"    \  'default': '',
"    \  'ruby': s:neoco_dicts_dir . '/ruby.dict',
"    \ }
"endif

"if !exists('g:neocomplete#delimiter_patterns')
"    let g:neocomplete#delimiter_patterns = {}
"endif
"let g:neocomplete#delimiter_patterns.cpp = ['::']


"********** vim-indent-guidesの設定 **********
let g:indent_guides_enable_on_vim_startup = 1       "vimを立ち上げたときに,自動的にvim-indent-guidesをオンにする
let g:indent_guides_start_level = 2                 "ガイドをスタートするインデントの量
let g:indent_guides_auto_colors = 0                 "自動カラーを無効
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#403D3D ctermbg=235   "奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#403D3D ctermbg=236   "偶数インデントのカラー
let g:indent_guides_guide_size = 1                  "ガイドの幅


"********** lightlineの設定 **********
"readonlyのアイコン変更オプション
"\ 'component': {
"\   'readonly': '%{&readonly?"":""}',
"\ }
"separatorの設定,
"\ 'separator': { 'left': '', 'right': '' },
"\ 'subseparator': { 'left': '', 'right': '' }
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'syntastic', 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'modified': 'LightLineModified',
    \   'fugitive': 'LightLineFugitive',
    \   'fileformat': 'LightLineFileformat',
    \   'filetype': 'LightLineFiletype',
    \   'fileencoding': 'LightLineFileencoding',
    \   'mode': 'LightLineMode',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag'
    \ },
    \ 'component_type': {
    \   'syntastic': 'error'
    \ }
    \ }

function! LightLineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


"***** 保存すると同時にsyntasticを動かし,かつlight#updateを呼ぶ *****
let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.c,*.cpp,*.cc,*.cs,*.java,*.py,*.rb,*.html,*.css,*.js call s:syntastic()
augroup END
function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction


"********** unite.vim **********
let g:unite_enable_start_insert = 1         "入力モードで開始する
let g:unite_source_history_yank_enable = 1  "ヒストリー/ヤンク機能を有効化

"***** unite.vim grepにag(The silver Searcher)を使用 *****
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif



"---------------------------------------------------------------------------------------------------



"********** キーマッピング **********
let mapleader = "\<space>"      "LeaderをSpaceキーに設定
"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>
"<ESC>でIMEを自動的にオフに
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
"command line windowを開く
nnoremap :: q:a
nnoremap / q/a


"***** プラグインのキーマッピング *****

nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>g :GundoToggle<CR>
nnoremap <Leader>l :TlistToggle<CR>

"** neocompleteのキーマッピング **
"Plugin key-mappings
inoremap <expr><C-k>    neocomplete#undo_completion()
inoremap <expr><C-l>    neocomplete#complete_common_string()
"Recommended key-mappings.
"<CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

"** neosnippetのキーマッピング **
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"** unite.vimのキーマッピング **
"prefix keyの設定
nmap <Space>t [unite]
"カレントディレクトリを表示
nnoremap <silent> [unite]c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite buffer file_mru<CR>
"最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite directory_mru<CR>
"バッファを表示
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"レジストリを表示
nnoremap <silent> [unite]r :<C-u>Unite register<CR>
"タブを表示
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
"ヒストリー/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite history/yank<CR>
"outline
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
"file_rec:!
nnoremap <silent> [unite]<CR> :<C-u>Unite file_rec:!<CR>

"unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    " ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}



"---------------------------------------------------------------------------------------------------



"********** 画面表示設定 **********
syntax on                       "ハイライト表示
set title                       "ターミナルのタイトルをセットする
set noshowmode                  "現在のモードを照会しない
set number                      "行番号を表示する
set laststatus=2                "ステータス行を常に表示
set cmdheight=2                 "メッセージ表示欄を2行確保
set cursorline                  "カーソル行の背景色を変える
set showmatch                   "対応する括弧を強調表示
"set helpheight=999              "ヘルプを画面いっぱいに書く
set list                        "不可視文字を表示
set nowrap                      "折り返しをしない
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%  "可視化した空白文字の表示形式

"********** カーソル移動関連設定 **********
set whichwrap=b,s,h,l,<,>,[,]   "行頭行末の左右移動で行をまたぐ
set mps+=<:>                    "<や>も括弧として認識
set backspace=indent,eol,start  "バックスペースを空白,行末,行頭でも使えるようにする
set scrolloff=16                "上下16行の視界を確保
set sidescrolloff=20            "左右スクロール時の視界を確保

"********** 文字設定 **********
set ambiwidth=double            "文脈によって解釈が異なる全角文字の幅を2に固定する

"********** 文字コード設定 **********
set encoding=utf-8              "vim
scriptencoding utf-8
set fileencoding=utf-8          "保存するファイル

"********** カラースキーマ設定 **********
set t_Co=256
colorscheme molokai
let g:molokai_origial=1

"highlight CursorLine ctermbg=lightgray "カーソル行のハイライトの色を変更

"********** ファイル処理関連設定 **********
set confirm                     "未保存のファイルがあるときは終了前に保存確認
set autoread                    "外部でファイルに変更がされた場合は読み直す
set hidden                      "ファイルを保存していなくても、別のファイルを開けるようにする
"set nobackup                   "ファイル保存時にバックアップファイルを作らない
"set noswapfile                 "ファイル編集中にスワップファイルを作らない

"********** タブ/インデント設定 **********
set tabstop=4                   "タブ幅をスペース4つ分にする
set expandtab                   "tabを半角スペースで挿入する
set shiftwidth=4                "vimが自動で生成するtab幅をスペース4つ分にする
set smartindent                 "改行時などに自動でインデントを設定する
"set softtabstop=2              "連続した空白に対してタブキーやバックスペースでカーソルが動く幅

"********** 検索/置換設定 **********
set hlsearch                    "検索文字列をハイライトする
set incsearch                   "インクリメンタルサーチを行う
set ignorecase                  "大文字と小文字を区別しない
set smartcase                   "大文字と小文字が混在した言葉で検索を行った場合に限り,大文字と小文字を区別する
set wrapscan                    "最後尾まで検索を終えたら次の検索で先頭に移動
"set gdefault                   "置換の時gオプションをデフォルトで有効にする

"********** 補完 **********
set wildmenu                    "コマンドラインモードでTABキーによる補完を有効化
set wildmode=list:longest,full  "複数マッチがある時は,全てのマッチを羅列し,共通する最長の文字列までが補完され,もう一度TABを押すと,完全に補完する
"set history=1000               "コマンド・検索パターンの履歴数

"********** 動作環境と統合関連の設定  **********
set clipboard=unnamed,autoselect "unnamed:ヤンクしたテキストそのままクリップボードにコピー, autoselect:vim上でハイライトして選択したテキストがクリップボードにコピー
set mouse=a                     "マウスの入力を受けつける
set shellslash                  "Windowsでもパスの区切り文字を/にする

"********** 各種ファイルの保存先指定 **********
"set viminfo+=n "viminfoファイルの場所指定
"set directory= "スワップファイルの作成ディレクトリ
"set undodir= "undoファイルの作成ディレクトリ
"set backupdir= "バックアップファイルの作成ディレクトリ
