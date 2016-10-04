" Author: Slevin Zhang <me@slevin.im>
" Source: https://github.com/s7evinz-settings/vimrc
" Inspired By: 'AssailantLF/vimrc', 'thoughtbot/dotfiles', /r/vim


" ===========================================================================
" VIM-PLUG {{{
" ===========================================================================
" (minimalist plugin manager)

call plug#begin()

" PRIMARY PLUGINS
Plug '0ax1/lxvc'                    " colorscheme / theme
Plug 'Raimondi/delimitMate'         " closing brackets, quotes, etc.
Plug 'gabrielelana/vim-markdown'    " improved markdown
" Plug 'itchyny/landscape.vim'        " colorscheme / theme
Plug 'itchyny/lightline.vim'        " better looking UI
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'             " fzf vim integration
Plug 'justinmk/vim-sneak'           " slim easy motion
Plug 'kristijanhusak/vim-hybrid-material' " material theme
Plug 'pangloss/vim-javascript'      " better javascript syntax
Plug 'leafgarland/typescript-vim'   " TypeScript syntax
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'terryma/vim-multiple-cursors' " multiple cursor
Plug 'tommcdo/vim-exchange'         " easy text exchange for vim
Plug 'tpope/vim-endwise'            " add 'end' in ruby
Plug 'tpope/vim-commentary'         " easier commenting
Plug 'tpope/vim-repeat'             " repeat for plugins
Plug 'tpope/vim-rsi'                " readline style insertion
Plug 'tpope/vim-surround'           " surroundings manipulation
Plug 'tpope/vim-unimpaired'         " many helpful mappings
if has('python') || has('python3')  " snippets
  Plug 'editorconfig/editorconfig-vim'
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
endif

call plug#end()


" }}}
" ===========================================================================
"  GENERAL SETTINGS {{{
" ===========================================================================

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set backspace=2
set nobackup
set nowritebackup
set noswapfile
set history=50
set showcmd
set laststatus=2  " Always display the status line
set autoread         " auto reload changed files
set autowrite     " Automatically :write before running commands
set synmaxcol=400    " don't highlight past 400 characters
set ignorecase       " search isn't case sensitive
set incsearch        " incremental search
set lazyredraw       " redraw the screen less often
set diffopt+=vertical " Always use vertical diffs
set splitbelow
set splitright


" }}}
" ===========================================================================
"  APPEARANCE/AESTHETIC {{{
" ===========================================================================

set t_Co=256     " 256 colors, please
set background=dark
" colorscheme landscape
colorscheme lxvc

" highlight cursor line on active window
augroup CursorLine
au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END


" }}}
" ===========================================================================
" TEXT AND FORMATTING {{{
" ===========================================================================

set encoding=utf-8
set autoindent
set smartindent
set linebreak
set tabstop=2       " Softtabs, 2 spaces
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set colorcolumn=81

" tabstop, softtabstop, shiftwidth
augroup filetype_specific
  au!
  au FileType java :setlocal ts=4 sts=4 sw=4 et
  au FileType c    :setlocal ts=4 sts=4 sw=4 et
  au FileType cpp  :setlocal ts=4 sts=4 sw=4 et
  au FileType make :setlocal ts=8 sts=8 sw=4 noet
augroup END

" {{{
augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=80
  autocmd FileType gitcommit setlocal spell

augroup END
" }}}

" }}}
" ===========================================================================
" KEY MAPPINGS + ALIASES {{{
" ===========================================================================
" anything related to plugins is located
" under its respective PLUGIN SETTINGS section

" ---------------------------------------------------------------------------
" REMAPS OF DEFAULTS {{{
" ---------------------------------------------------------------------------

" Y yanks until EOL, more like D and C
nnoremap Y y$
" U as a more sensible redo
nnoremap U <C-r>
" use ctrl j for Join line
noremap <C-j> J
" [S]plit line (sister to [J]oin lines)
" nnoremap <C-s> i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>
nnoremap <C-s> :!echo fuck
" big J / K travel 10 lines
noremap J 10j
noremap K 10k
" Ctrl h / l for easy beginning / end of line
noremap <C-h> ^
noremap <C-l> $
" Enter for EOL
" nnoremap <CR> G$
" qq to record, Q to replay
nnoremap Q @q
" move by wrapped lines instead of line numbers
noremap j gj
noremap k gk
noremap gj 5j
noremap gk 5k
" Left right flipping pages, remap less used keys
nnoremap <Left> <C-b>
nnoremap <Right> <C-f>
nnoremap <Up> <C-u>
nnoremap <Down> <C-d>
" When jump to next match also center screen
noremap n nzz
noremap N Nzz

" }}}
" ---------------------------------------------------------------------------
" NORMAL MAPS {{{
" ---------------------------------------------------------------------------

" circular windows navigation
nnoremap <Tab> <c-W>w
nnoremap <Backspace> <c-W>W

" }}}
" ---------------------------------------------------------------------------
" LEADER MAPS {{{
" ---------------------------------------------------------------------------

let mapleader = " "     " space leader

" Switch between the last two files
nnoremap <Leader><Tab> <c-^>
" write file / all files
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :wa<CR>
" quick all windows
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa<CR>
" quick without save
nnoremap <Leader>1 :q!<CR>
nnoremap <Leader>! :qa!<CR>
" save & quick all windows
nnoremap <Leader>x :x<CR>
nnoremap <Leader>X :xa<CR>
" copy paste from system clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
" Paste above
noremap <Leader>P "+P

" quickly open and edit vimrc within vim
noremap <Leader>vi :e ~/.vimrc<CR>
noremap <Leader>vn :vs ~/.config/nvim/init.vim<CR>
noremap <Leader>V :tabe ~/.vimrc<CR>
nnoremap <Leader>so :so ~/.vimrc<CR>

" open current file with Mac OS default
nnoremap <leader>o :!open %:p<CR><CR>
" open current file with sublime
nnoremap <leader>sl :!subl %:p<CR><CR>

" close tab
nnoremap <Leader>tc :tabclose<CR>

" }}}
" ---------------------------------------------------------------------------
" COMMAND ALIASES {{{
" ---------------------------------------------------------------------------

" Clear Trailing White spaces
cabbrev ctw s/\s\+$//e
" delete all buffers
cabbrev bdall 0,999bd!

" }}}
" ---------------------------------------------------------------------------

" }}}
" ===========================================================================
" PLUGIN SETTINGS {{{
" ===========================================================================


" delimitMate {{{
" auto new line space expansion
let delimitMate_expand_space=1
let delimitMate_expand_cr=1
" semicolon end
inoremap <C-l> <C-o>A;<Esc>
" }}}

" NerdTree {{{
nnoremap <Leader>n :NERDTreeToggle<CR><C-w>=
" Auto delete buffer
let NERDTreeAutoDeleteBuffer = 1
" Show hidden file by default
let NERDTreeShowHidden = 1
" so that I can use default J/K within NT
let NERDTreeMapJumpLastChild = 'gj'
let NERDTreeMapJumpFirstChild = 'gk'
" so that I can use vim-sneak within NT
let NERDTreeMapOpenVSplit = '<C-v>'
" }}}

" vim-sneak {{{
" Emulate easyMotion
let g:sneak#streak=1
let g:sneak#use_ic_scs=1 " case insenstive
" }}}

" fzf.vim {{{
nnoremap <silent><Leader>[ :FZF<CR>
nnoremap <silent><Leader><Leader> :Buffers<CR>
" }}}

" vim-markdown {{{
" checkbox done
let g:markdown_mapping_switch_status = '<Leader>d'
" }}}

" lightline {{{
" let g:lightline = {
"       \ 'colorscheme': 'landscape',
"       \ }
" }}}

" }}}
" ===========================================================================
