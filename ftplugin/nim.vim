nnoremap <buffer> <Leader>kk I# <Esc>j
nnoremap <buffer> <Leader>jj ^xxj

vnoremap <buffer> <Leader>kk <S-v><C-v>0I# <Esc>
vnoremap <buffer> <Leader>jj <Esc>'<0<C-v>'>lx

nnoremap <buffer> <expr> <Leader>cc g:MakeCmd('nim c -r ', 1) . g:esc_term . g:move_left
