function! Comment()
    execute "normal! I;\<Esc>j"
endfunction
function! Uncomment()
    execute "normal! ^xj"
endfunction
function! StartREPL()
endfunction
function! StopREPL()
endfunction
function! RunScript()
    "return ":w\<CR>\<C-w>\<C-l>asbcl --script " . expand('%:r')
endfunction
function! RunScriptSel()
endfunction

" Clojure
"nnoremap <expr> <Leader>cs RunCmd('clj', 0) . esc_term . move_left
"nnoremap <expr> <Leader>cr ":w\<CR>\<C-w>\<C-l>a(clojure.main/load-script \"".expand('%:t')."\")\<CR>".esc_term.move_left

