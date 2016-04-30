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
call dein#add('Shougo/unite.vim')                   "任意の[候補](ファイル名やバッファ名など)から[選択]を行い,[種類]に応じた[操作](開く,削除など)を実行. []はプラグインを用いて拡張
call dein#add('scrooloose/nerdtree')                "ファイルをツリー表示
call dein#add('nathanaelkane/vim-indent-guides')    "インデントに色を付ける

call dein#end()

filetype plugin indent on


"vimを立ち上げたときに,自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup=1


"** キーマッピング **
nnoremap :tree :NERDTreeToggle



"** 画面表示設定 **
syntax on                       "ハイライト表示
set title                       "ターミナルのタイトルをセットする
set showmode                    "現在のモードを照会する
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
