nnoremap <buffer> <Leader>kk I;<Esc>j
nnoremap <buffer> <Leader>jj ^xj

nnoremap <buffer> <expr> <Leader>cs MakeCmd('clj', 0) . g:esc_term . g:move_left
nnoremap <buffer> <expr> <Leader>cc MakeCmd('clj', 1) . g:esc_term . g:move_left
nnoremap <buffer> <expr> <Leader>cr MakeCmd("(clojure.main/load-script \"".expand('%:t')."\")", 0) . g:esc_term . g:move_left

