nnoremap <buffer> <Leader>kk I//<Esc>j
nnoremap <buffer> <Leader>jj ^xxj

nnoremap <buffer> <expr> <Leader>co g:MakeCmd('rustc', 1) . g:esc_term . g:move_left
nnoremap <buffer> <expr> <Leader>cc g:MakeCmd('cargo run', 0) . g:esc_term . g:move_left
nnoremap <buffer> <expr> <Leader>cw g:MakeCmd('cargo web start', 0) . g:esc_term . g:move_left

