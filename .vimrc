"** dein.vimの設定 **
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
call dein#add('Shougo/unite.vim')                   "任意の[候補](ファイル名やバッファ名など)から[選択]を行い,[種類]に応じた[操作](開く,削除など)を実行. []はプラグインを用いて拡張
call dein#add('Shougo/vimshell.vim')                "vimをシェルとして使用.また,unite.vimの[操作]にvimshellで実行する機能を追加
call dein#add('rking/ag.vim')                       "ag(the_silver_sercher)と連携. 高速にファイル検索可能
call dein#add('cohama/lexima.vim')                  "autoclose
call dein#add('gregsexton/gitv')                    "gitkコマンドのようなコミット履歴を専用バッファに表示
call dein#add('cohama/agit.vim')                    "Gitの差分を表示

call dein#end()

filetype plugin indent on



let g:indent_guides_enable_on_vim_startup=1         "vimを立ち上げたときに,自動的にvim-indent-guidesをオンにする
let g:indent_guides_start_level=2                   "ガイドをスタートするインデントの量
let g:indent_guides_auto_colors=0                   "自動カラーを無効
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#403D3D ctermbg=235   "奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#403D3D ctermbg=236   "偶数インデントのカラー
let g:indent_guides_guide_size=1                    "ガイドの幅


"** lightlineの設定 **
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


"** 保存すると同時にsyntasticを動かし,かつlight#updateを呼ぶ **
let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.c,*.cpp,*.cc,*.cs,*.java,*.py,*.rb,*.html,*.css,*.js call s:syntastic()
augroup END
function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction



"** キーマッピング **
let mapleader = "\<space>"          "LeaderをSpaceキーに設定
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F6> :GundoToggle<CR>
nnoremap <F7> :TlistToggle<CR>

"neosnippetのキーマッピング
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

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





"** 画面表示設定 **
syntax on                       "ハイライト表示
set title                       "ターミナルのタイトルをセットする
set noshowmode                  "現在のモードを照会しない
set number                      "行番号を表示する
set laststatus=2                "ステータス行を常に表示
set cmdheight=2                 "メッセージ表示欄を2行確保
set cursorline                  "カーソル行の背景色を変える
set showmatch                   "対応する括弧を強調表示
set helpheight=999              "ヘルプを画面いっぱいに書く
set list                        "不可視文字を表示
set nowrap                      "折り返しをしない
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%  "可視化した空白文字の表示形式

"** カーソル移動関連設定 **
set whichwrap=b,s,h,l,<,>,[,]   "行頭行末の左右移動で行をまたぐ
set mps+=<:>                    "<や>も括弧として認識
set backspace=indent,eol,start  "バックスペースを空白,行末,行頭でも使えるようにする
set scrolloff=16                "上下16行の視界を確保
set sidescrolloff=20            "左右スクロール時の視界を確保

"** 文字設定 **
set ambiwidth=double            "文脈によって解釈が異なる全角文字の幅を2に固定する

"** 文字コード設定 **
set encoding=utf-8              "vim
scriptencoding utf-8
set fileencoding=utf-8          "保存するファイル

"** カラースキーマ設定 **
set t_Co=256
colorscheme molokai
let g:molokai_origial=1

"highlight CursorLine ctermbg=lightgray "カーソル行のハイライトの色を変更

"** ファイル処理関連設定 **
set confirm                     "未保存のファイルがあるときは終了前に保存確認
set autoread                    "外部でファイルに変更がされた場合は読み直す
set hidden                      "ファイルを保存していなくても、別のファイルを開けるようにする

"** タブ/インデント設定 **
set tabstop=4                   "タブ幅をスペース4つ分にする
set expandtab                   "tabを半角スペースで挿入する
set shiftwidth=4                "vimが自動で生成するtab幅をスペース4つ分にする
set smartindent                 "改行時などに自動でインデントを設定する

"** 検索/置換設定 **
set hlsearch                    "検索文字列をハイライトする
set incsearch                   "インクリメンタルサーチを行う
nmap <ESC><ESC> :nohlsearch<CR><ESC>
    "Escの2回押しでハイライト消去

"** その他 **
set clipboard=unnamed,autoselect  "unnamed:ヤンクしたテキストそのままクリップボードにコピー
                                  "autoselect:vim上でハイライトして選択したテキストがクリップボードにコピー

"** 各種ファイルの保存先指定 **
"set viminfo+=n "viminfoファイルの場所指定
"set directory= "スワップファイルの作成ディレクトリ
"set undodir= "undoファイルの作成ディレクトリ
"set backupdir= "バックアップファイルの作成ディレクトリ
