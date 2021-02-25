nnoremap <buffer> <Leader>kk I//<Esc>j
nnoremap <buffer> <Leader>jj ^xxj

nnoremap <buffer> <expr> <Leader>cc g:MakeCmd('./build.sh', 0) . g:esc_term . g:move_left
