"let mapleader = "\<space>" 
let mapleader = " " 

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

noremap <leader>w <Esc>:w<CR>
noremap <leader>x <Esc>:q!<CR>

" Toggle line wrap
"nnoremap gw :set wrap!<CR>

" Toggle relative line numbers
nnoremap <leader>3 :set relativenumber!<CR>

" Reload config
nnoremap <leader>c :source ~/.vimrc<CR>

" Un-highlight search matches
nnoremap <Esc> :nohlsearch<CR>

" Use 'very magic' mode for search
noremap <leader>/ /\v
noremap <leader>? ?\v

" Alphabetize selected lines based on first word
xnoremap <leader>a :sort /\<\S\+\>\%>0<CR>

" Substitute with 'very magic' mode enabled (standard regex symbols)
"nnoremap <leader>s :%s/\v/gI<Left><Left><Left>
nnoremap s :%s/\v/gcI<Left><Left><Left><Left>

" Substitute word under cursor
nnoremap <leader>s :%s/\v<<C-r><C-w>>//gcI<Left><Left><Left><Left>

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
"xnoremap <leader>p "_dP
"xnoremap p "_dgP
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
xnoremap <leader>X "+x

" Paste from system clipboard
nnoremap <leader>p "+gP
xnoremap <leader>p "_d"+gP

" H/L go to start/end of line
noremap H 0^
noremap L $
onoremap H ^
onoremap L $

" U to redo
"nnoremap U <C-r>

" Paste from system clipboard
"nnoremap <leader><C-v> "+gP
cnoremap <C-v> <C-R>+
inoremap <C-v> <Esc>"+gpi

" Yank entire file to system clipboard
nnoremap <C-y> mygg"+yG`y

" Move selected text up/down, reformat, then reselect (OG vim)
"xnoremap J :m '>+1<CR>gv=gv
"xnoremap K :m '<-2<CR>gv=gv

" VS Code move/reformat/reselect
"xnoremap J dpV']k=gv
"xnoremap K dkPV']k=gv

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
