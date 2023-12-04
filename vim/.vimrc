let mapleader = "\<Space>"

" Line numbers
set number
" Relative line numbers
set relativenumber
" Minimum # of line numbers to display above/below cursor
set scrolloff=8
" Ignore case when searching
set ignorecase
" Overrides ignorecase if search pattern includes uppercase letters
set smartcase
" Highlight search matches
set hlsearch
" Incrementally highlight matches for search pattern while typing
set incsearch
" Text width used when formatting lines with gq
set textwidth=120
" Command history
set history=10000
" Vim and system share same clipboard
"set clipboard=unnamed

noremap j gj
noremap k gk

noremap <leader>w <Esc>:w<CR>
nnoremap <leader>x :q!<CR>

" Enable standard Ctrl+Backspace/Ctrl+Del behavior in insert mode
inoremap <C-Del> <C-o>dw
inoremap <C-BS> <C-o>db

" Save file as sudo
cmap w!! w !sudo tee > /dev/null %

" Toggle line wrap
nnoremap gw :set wrap!<CR>

" Toggle relative line numbers
nnoremap <leader>3 :set relativenumber!<CR>

" Reload config
nnoremap <leader>c :source ~/.vimrc<CR>

" Un-highlight search matches
nnoremap <Esc> <Esc>:nohlsearch<CR>

" Use 'very magic' mode for search
" noremap <leader>/ /\v
" noremap <leader>? ?\v

" Quick substitute command
nnoremap s :%s//gI<Left><Left><Left>

" Substitute word under cursor across entire file
nnoremap <leader>s :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

" Substitute word under cursor once; use . to repeat
nnoremap <leader>e *Ncgn

" Create horizontal/vertical splits
"noremap <leader>h <Esc><C-w>s
noremap <leader>v <Esc><C-w>v

" Split navigation
noremap <Left> <Esc><C-W>h
noremap <Right> <Esc><C-W>l

" Tab navigation
noremap <C-h> <Esc>gT
noremap <C-l> <Esc>gt

" Center screen after scrolling motions
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz
nnoremap [[ [[zz
nnoremap ]] ]]zz
nnoremap [] []zz
nnoremap ][ ][zz

" Don't move cursor when searching with * or #
nnoremap * *N
nnoremap # #N

" n/N always go forward/back regardless of how search was initiated
nnoremap n /<CR>zz
nnoremap N ?<CR>zz

" Keep current text in register when pasting
xnoremap p "_dP

" Delete to void register; preserves text currently in register
noremap <leader>d "_d
noremap <leader>D "_D

" Make Y behave like C and D
nnoremap Y y$

" Yank to system clipboard
noremap <leader>y "+y
nnoremap <leader>Y "+y$
xnoremap <leader>Y "+y

" Cut to system clipboard
xnoremap <leader>x "+x

" Paste from system clipboard
nnoremap <leader>p "+p
xnoremap <leader>p "_d"+P

" H/L go to start/end of line
noremap H 0^
noremap L $
onoremap H ^
onoremap L $
noremap ^ 0^

" U to redo
"nnoremap U <C-r>

" Paste from system clipboard
cnoremap <C-v> <C-R>+
inoremap <C-v> <C-R>+ 

" Yank entire file to system clipboard
nnoremap <C-y> mygg"+yG`y

" Move selected text up/down, reformat, then reselect (OG vim)
"xnoremap J :m '>+1<CR>gv=gv
"xnoremap K :m '<-2<CR>gv=gv

" Don't move cursor when joining below line
nnoremap J mzJ0`z

" Split (opposite of J for join)
nnoremap S yl/<C-r>0<CR>Ncgn<C-r>0<Del><CR><Esc>n:nohlsearch<CR>

" Reselect text after indenting/dedenting
xnoremap > >gv
xnoremap < <gv

" Go to last cursor position for marks rather than start of line
nnoremap ' `
nnoremap '' ``
"nnoremap ` '
"nnoremap `` ''
