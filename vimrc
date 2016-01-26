"" a very simple rc for quick run of vim
"" only most needed config is setting here
"
"" Use Vim settings, rather then Vi settings (much better!).
"" This must be first, because it changes other options as a side effect.
set nocompatible
"
"" allow backspacing over everything in insert mode
set backspace=indent,eol,start
"
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number " show line numbers
set numberwidth=4 "Numbering up to 5 spaces
set cursorline "Highlight current line
set nowrap " Turn off word wrapping

" Don't use Ex mode, use Q for formatting
map Q gq

set t_Co=256 " 256 colors
if (&t_Co > 2)
  syntax on 
  set background=dark 
  "colorscheme ir_black
  "colorscheme herald 
  colorscheme vividchalk
  set hlsearch
end

if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    " as of March 2013, this works:
    set ttymouse=xterm2

    " previously, I found that ttymouse was getting reset, so had
    " to reapply it via an autocmd like this:
    autocmd VimEnter,FocusGained,BufEnter * set ttymouse=xterm2
  endif
endif


"If support for autocommand
if has("autocmd")
  "" set filetype check on
  filetype plugin indent on

  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END

else

  set autoindent " always set autoindenting on

endif " has("autocmd")

"Enable folding
if has('folding')
  set foldenable
  set foldmethod=syntax
  set foldlevel=1
  "set foldnestmax=2
  set foldlevelstart=99
  " Space to toggle a fold
  nnoremap <space> za
endif

"" set tabstop value and shift width 
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character if empty
let mapleader = ""
" Hide search highlighting
map <Leader>h :set invhls <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Toggle Tagbar using F9
map <F9> :TagbarToggle <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p
" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p:call setreg('"', getreg('0'))<CR>

" For Haml & sass
au! BufRead,BufNewFile *.haml setfiletype haml
autocmd BufNewFile,BufRead *.scss setf sass

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Maps autocomplete to tab
imap <Tab> <C-N>

imap <C-L> <Space>=><Space>

" Shortcut to auto indent whole file
map  <silent> <F5> mmgg=G'm
imap <silent> <F5> <Esc> mmgg=G'm

" Display extra whitespace
" set list listchars=tab:»·,trail:·

"autocmd FileType haml set foldmethod=indent

" JSX plugin
let g:jsx_ext_required = 0

" rails projection
let g:rails_projections = {
  \ "spec/factories/*.rb" : {"command": "factory"},
  \ "config/routes.rb" : {"command": "routes"},
  \ "db/schema.rb" : {"command": "schema"},
  \ "app/notifiers/*_notifier.rb" : {
  \   "command": "notifier",
  \   "template":
  \   ["class %SNotifier < ApplicationNotifier", "end"]
  \   },
  \ "app/policies/*_policy.rb" : {
  \   "command": "policy",
  \   "template":
  \   ["class %SPolicy < ApplicationPolicy", "end"]
  \   }
  \ }

  ",o for a new line below
" End of remapping

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
"set ignorecase
set smartcase

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;

" Wildignore for command-T
set wildignore+=node_modules/*

let g:fuf_splitPathMatching=1

"Replace global and not just once per line
set gdefault
"
set sessionoptions+=unix,slash
"
"" encodings configure
set fileencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb2312,cp936
"
""setting about indent
set autoindent
set smartindent
"
""setting about old window resizing behavior when open a new window
set winfixheight
"" not let all windows keep the same height/width
set noequalalways

if has('gui_running')
  "Disable beep and sound
  :set noerrorbells
  :set visualbell
  "Remove gui toolbar
  set guioptions-=T
  :set t_vb=
  ":set guifont=Consolas\ 11
endif

"call pathogen#runtime_append_all_bundles() 
call pathogen#infect()
call pathogen#helptags()

" Remap w!! to write with sudo permissions
cmap w!! %!sudo tee > /dev/null %

" Status line format:
" {buffer number}: {file name, relative path to the current working directory}{modified flag}{readonly flag}
" {help flag}{preview flag} [file type, encoding, format] [current line-total lines, current column][position percentage in file]
" %= is split point with right
" Then fugitive
set statusline=%n:\ %f%m%r%h%w\ [%Y,%{&fileencoding},%{&fileformat}]\ %{fugitive#statusline()}\ %{SyntasticStatuslineFlag()}%=[%l-%L,%v][%p%%]
let g:airline_powerline_fonts = 1

" Local config
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
