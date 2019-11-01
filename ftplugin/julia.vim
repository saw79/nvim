function! Comment()
    return "I#\<Esc>j"
endfunction
function! Uncomment()
    return "^xj"
endfunction
function! CommentSel()
    return "\<S-v>\<C-v>0I#\<Esc>"
endfunction
function! UncommentSel()
    return "\<Esc>'<0\<C-v>'>x"
endfunction
function! StartREPL()
    let g:repl = 1
    return g:MakeCmd('julia', 0) . g:esc_term . g:move_left
endfunction
function! StopREPL()
    let g:repl = 0
    return ":w\<CR>\<C-w>\<C-l>a\<C-d>"
endfunction
function! RunScript()
    if exists('g:repl') && g:repl
        return ":w\<CR>\<C-w>\<C-l>ainclude(\"" . expand('%:t') . "\")\<CR>" . g:esc_term . g:move_left
    else
        return g:MakeCmd('julia', 1) . g:esc_term . g:move_left
    endif
endfunction
function! RunScriptSel()
    return "y\<CR>\<C-w>\<C-l>pa\<CR>\<CR>"
endfunction

