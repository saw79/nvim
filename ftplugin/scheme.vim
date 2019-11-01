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
    return ":w\<CR>\<C-w>\<C-l>aracket " . expand('%:t') . "\<CR>" . g:esc_term . g:move_left
endfunction
function! RunScriptSel()
endfunction

