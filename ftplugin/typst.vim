" nnoremap <buffer> <F5> <cmd>vsplit<cr><cmd>terminal typst-live %<cr>A
nnoremap <buffer> <F5> <cmd>silent TypstWatch<cr>

augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.tex mkview
  autocmd BufWinEnter *.tex silent! loadview
augroup END
