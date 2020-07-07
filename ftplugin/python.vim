setlocal tabstop=4
setlocal expandtab
setlocal shiftwidth=4

nnoremap <buffer> <Leader>kk I#<Esc>j
nnoremap <buffer> <Leader>jj ^xj

vnoremap <buffer> <Leader>kk <S-v><C-v>0I#<Esc>
vnoremap <buffer> <Leader>jj <Esc>'<0<C-v>'>x

nnoremap <buffer> <expr> <Leader>cc g:MakeCmd('python', 1) . g:esc_term . g:move_left

nnoremap <buffer> <expr> <Leader>cs g:MakeCmd('ipython', 0) . g:esc_term . g:move_left
nnoremap <buffer> <expr> <Leader>cq g:MakeCmd('quit', 0) . g:esc_term . g:move_left

nnoremap <buffer> <expr> <Leader>cr g:MakeCmd('%run', 2) . g:esc_term . g:move_left
vnoremap <buffer>        <Leader>cr y<CR><C-w><C-l>pa<CR><CR><C-\><C-n><C-w>h
nnoremap <buffer>        <Leader>cl <S-v>y<CR><C-w><C-l>pa<CR><CR><C-\><C-n><C-w>h

nnoremap <buffer> <Leader>cp :w<CR><C-w><C-l>apython<CR>
nnoremap <buffer> <Leader>ci :w<CR><C-w><C-l>aC:\Users\swack\Anaconda3\Scripts\activate<CR><Esc>

nnoremap <buffer> <Leader>do oimport pdb; pdb.set_trace()<Esc>
nnoremap <buffer> <Leader>dO Oimport pdb; pdb.set_trace()<Esc>

