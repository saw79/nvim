nnoremap <buffer> <Leader>kk I//<Esc>j
nnoremap <buffer> <Leader>jj ^xxj

nnoremap <buffer> <expr> <Leader>cc g:MakeCmd('./build.sh', 0) . g:esc_term . g:move_left
"nnoremap <buffer> <expr> <Leader>cc g:MakeCmd('make', 0) . g:esc_term . g:move_left

"nnoremap <expr> <Leader>cc RunCmd('g++ main.cpp -o main.exe', 0) . esc_term . move_left
"nnoremap <expr> <Leader>cg RunCmd('g++ -g main.cpp -o main.exe', 0) . esc_term . move_left

