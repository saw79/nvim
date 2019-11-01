function! Comment()
    return "I;\<Esc>j"
endfunction
function! Uncomment()
    return "^xj"
endfunction
function! StartREPL()
endfunction
function! StopREPL()
endfunction
function! RunScript()
    return ":w\<CR>\<C-w>\<C-l>asbcl --script " . expand('%:t') . "\<CR>" . g:esc_term . g:move_left
endfunction
function! RunScriptSel()
endfunction

