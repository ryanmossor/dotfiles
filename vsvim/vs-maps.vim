nnoremap <leader><leader> :source ~/.vsvimrc<CR>

" Substitute word under cursor across entire file in "very magic" mode
nnoremap <leader>s :%s/\v<<C-r><C-w>>//gI<Left><Left><Left>

" Move/reformat/reselect
xnoremap J dpV']=gv
xnoremap K dkPV']=gv

nnoremap <leader>bs :vsc Build.BuildSolution<CR>

"nnoremap gD :vsc Debug.ShowNextStatement<CR>
noremap <leader>bp :vsc Debug.ToggleBreakpoint<CR>

nnoremap [g :vsc Diff.PreviousDifference<CR>
nnoremap ]g :vsc Diff.NextDifference<CR>

" Simulate hover
nnoremap K :vsc Edit.QuickInfo<CR>

nnoremap gd :vsc Edit.GoToDefinition<CR>
nnoremap gi :vsc Edit.GoToImplementation<CR>
nnoremap gr :vsc Edit.FindAllReferences<CR>
nnoremap gw :vsc Edit.ToggleWordWrap<CR>
noremap <leader>/ :vsc Edit.ToggleLineComment<CR>
nnoremap <C-p> :vsc Edit.GoToFile<CR>
nnoremap <leader>f :vsc Edit.GoToFile<CR>
nnoremap <leader>F :vsc Edit.FindInFiles<CR>
nnoremap <leader>R :vsc Edit.ReplaceinFiles<CR>

" Parameter help in insert mode
inoremap <C-h> <C-o>:vsc Edit.ParameterInfo<CR>

" Peek git diff
nnoremap <leader>gd :vsc Edit.PeekDifference<CR>

" Close other tabs
nnoremap gco :vsc File.CloseOtherTabs<CR> 

nnoremap <leader>r :vsc Refactor.Rename<CR>

nnoremap <C-,> :vsc Tools.Options<CR>

noremap <C-o> :vsc View.NavigateBackward<CR>
noremap <C-i> :vsc View.NavigateForward<CR>

" Jump to next diagnostic message
nnoremap ]d :vsc View.NextError<CR>
nnoremap [d :vsc View.PreviousError<CR>

" Code actions
nnoremap <leader>ca :vsc View.QuickActions<CR>
xnoremap <leader>ca :vsc View.QuickActions<CR>
nnoremap <leader>. :vsc View.QuickActions<CR>
xnoremap <leader>. :vsc View.QuickActions<CR>

nnoremap <leader>E :vsc View.SolutionExplorer<CR>

" Close unpinned
nnoremap gcu :vsc Window.CloseAllButPinned<CR>
nnoremap Q :vsc Window.CloseAllDocuments<CR>
nnoremap <leader>P :vsc Window.PinTab<CR>

nnoremap <C-j> :vsc Window.GoToPinnedTab1<CR>
nnoremap <C-k> :vsc Window.GoToPinnedTab2<CR>
nnoremap <C-l> :vsc Window.GoToPinnedTab3<CR>
nnoremap <C-;> :vsc Window.GoToPinnedTab4<CR>
