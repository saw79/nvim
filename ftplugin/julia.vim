set tabstop=4
set expandtab
set shiftwidth=4

nnoremap <buffer> <Leader>kk I#<Esc>j
nnoremap <buffer> <Leader>jj ^xj

nnoremap <buffer> <expr> <Leader>cs g:MakeCmd('julia', 0) . g:esc_term . g:move_left
nnoremap <buffer> <expr> <Leader>cr ":w\<CR>\<C-w>\<C-l>ainclude(\"" . expand('%:t') . "\")\<CR>" . g:esc_term . g:move_left

nnoremap <buffer> <expr> <Leader>cc g:MakeCmd('julia', 1) . g:esc_term . g:move_left

