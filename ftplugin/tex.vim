" nnoremap <buffer> <F6> <cmd>vsplit<cr><cmd>terminal xelatex %<cr>A

nnoremap <buffer> <F5> <cmd>ToggleTerm size=10 direction=horizontal<cr><cmd>terminal latexmk -pvc --shell-escape *.tex<cr>A
nnoremap <buffer> <F6> <cmd>ToggleTerm size=10 direction=horizontal<cr><cmd>terminal latexmk -pvc *.tex<cr>A

augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.tex mkview
  autocmd BufWinEnter *.tex silent! loadview
augroup END
