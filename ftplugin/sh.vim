nnoremap <buffer> <Leader>kk I#<Esc>j
nnoremap <buffer> <Leader>jj ^xj

vnoremap <buffer> <Leader>kk <S-v><C-v>0I#<Esc>
vnoremap <buffer> <Leader>jj <Esc>'<0<C-v>'>x

nnoremap <buffer> <expr> <Leader>cc g:MakeCmd('sh', 1) . g:esc_term . g:move_left

