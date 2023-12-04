nnoremap <leader>c :source ~/.vsvimrc<CR>

" Substitute with 'very magic' mode enabled (standard regex symbols)
nnoremap s :%s//gI<Left><Left><Left> 

" Substitute word under cursor across entire file in "very magic" mode
nnoremap <leader>s :%s/\v<<C-r><C-w>>//gI<Left><Left><Left>

" VsVim move/reformat/reselect
vnoremap J dpV']=gv
vnoremap K dkPV']=gv

nnoremap <leader>bs :vsc Build.BuildSolution<CR>

"nnoremap gD :vsc Debug.ShowNextStatement<CR>
noremap <leader>bp :vsc Debug.ToggleBreakpoint<CR>

nnoremap [g :vsc Diff.PreviousDifference<CR>
nnoremap ]g :vsc Diff.NextDifference<CR>

nnoremap K :vsc Edit.QuickInfo<CR>
nnoremap gh :vsc Edit.QuickInfo<CR>
nnoremap gi :vsc Edit.GoToImplementation<CR>
nnoremap gr :vsc Edit.FindAllReferences<CR>
"nnoremap gw :vsc Edit.ToggleWordWrap<CR>
noremap <leader>/ :vsc Edit.ToggleLineComment<CR>
nnoremap <C-p> :vsc Edit.GoToFile<CR>
nnoremap <leader>f :vsc Edit.GoToFile<CR>
nnoremap <leader>F :vsc Edit.FindInFiles<CR>
" Parameter help in insert mode
inoremap <C-h> <C-o>:vsc Edit.ParameterInfo<CR>
" peek (g)it (d)iff
nnoremap <leader>gd :vsc Edit.PeekDifference<CR>

" (g)o (c)lose (o)thers
nnoremap gco :vsc File.CloseAllButThis<CR> 

nnoremap <leader>r :vsc Refactor.Rename<CR>
"nnoremap gR :vsc Refactor.Rename<CR>

nnoremap <C-,> :vsc Tools.Options<CR>

noremap <C-o> :vsc View.NavigateBackward<CR>
noremap <C-i> :vsc View.NavigateForward<CR>
nnoremap ]d :vsc View.NextError<CR>
nnoremap [d :vsc View.PreviousError<CR>
" (c)ode (a)ctions
nnoremap <leader>ca :vsc View.QuickActions<CR>
nnoremap <leader>. :vsc View.QuickActions<CR>
nnoremap <leader>E :vsc View.SolutionExplorer<CR>

" (g)o (c)lose (u)npinned
nnoremap gcu :vsc Window.CloseAllButPinned<CR>
nnoremap Q :vsc Window.CloseAllDocuments<CR>
nnoremap <leader>P :vsc Window.PinTab<CR>

" Visual Studio extension
nnoremap <leader>VSC :vsc OpeninVisualStudioCode<CR>
