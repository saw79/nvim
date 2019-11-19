nnoremap <buffer> <Leader>kk I--<Esc>j
nnoremap <buffer> <Leader>jj ^xxj

nnoremap <buffer> <expr> <Leader>cc g:MakeCmd('stack build', 1) . g:esc_term . g:move_left

nnoremap <buffer> <expr> <Leader>cs g:MakeCmd('stack ghci', 0) . g:esc_term . g:move_left
nnoremap <buffer> <expr> <Leader>cq g:MakeCmd(':q', 0) . g:esc_term . g:move_left

nnoremap <buffer> <expr> <Leader>rr MakeCmd('stack run', 0) .esc_term . move_left

