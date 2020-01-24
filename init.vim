" --------------------------- PLUGINS -----------------------------------

call plug#begin()
Plug 'morhetz/gruvbox'
"Plug 'arcticicestudio/nord-vim'
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

" --------------------------- CORE -----------------------------------

"syntax enable
"colorscheme desert
colorscheme gruvbox
"colorscheme nord
set background=dark

set number
set relativenumber

set tabstop=4 " makes tab size = 4
set expandtab " inserts spaces when tab is pressed
set shiftwidth=4 " makes indenting = tabbing

set hlsearch
set cursorline

nnoremap <Space> <nop>
let mapleader = " "

" --------------------------- BASIC -----------------------------------

inoremap jk <Esc>

nnoremap <Leader>bl :w<CR>:ls<CR>:b 
nnoremap <Leader>BL :ls<CR>:b
nnoremap <Leader>bb :w<CR>:b#<CR>

nnoremap <Leader>ch :noh<CR>
nnoremap <Leader>cde :cd %:h<CR>

" --------------------------- BASIC EDITING -----------------------------------

" Easier macros
nnoremap Q @q
" Replace in line
nnoremap <Leader>rl :s/
" Replace in file
nnoremap <Leader>rf :%s/

" My surround functions
function! GetLChar(ch)
    if a:ch == ')'
        return '('
    elseif a:ch == ']'
        return '['
    elseif a:ch == '}'
        return '{'
    elseif a:ch == '>'
        return '<'
    else
        return a:ch
    endif
endfunction
function! GetRChar(ch)
    if a:ch == '('
        return ')'
    elseif a:ch == '['
        return ']'
    elseif a:ch == '{'
        return '}'
    elseif a:ch == '<'
        return '>'
    else
        return a:ch
    endif
endfunction
function! SurroundWord(ch)
    let lch = GetLChar(a:ch)
    let rch = GetRChar(a:ch)
    let cmd = "lbi" . lch . "\<Esc>ea" . rch . "\<Esc>"
    return cmd
endfunction
function! SurroundSelection(ch)
    let lch = GetLChar(a:ch)
    let rch = GetRChar(a:ch)
    let cmd = "\"zdi" . lch . "\<Esc>\"zpa" . rch ."\<Esc>"
    return cmd
endfunction
nnoremap <expr> <Leader>ss SurroundWord(input(''))
vnoremap <expr> <Leader>ss SurroundSelection(input(''))

nnoremap <Leader>ii <S-v><C-a>
nnoremap <Leader>id <S-v><C-x>

" --------------------------- TERMINAL -----------------------------------

" Clear terminal
"nnoremap <Leader>cl <C-w>lacls<CR><C-\><C-n><C-w>h
" Open right
nnoremap <C-Right> :vsp<CR><C-w><C-l>:term<CR><C-w><C-h>
" Open down
nnoremap <C-Down> :sp<CR><C-w><C-j>:term<CR><C-w><C-k>

" Movement
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
tnoremap <C-h> <C-\><C-n><C-w><C-h>
tnoremap <C-j> <C-\><C-n><C-w><C-j>
tnoremap <C-k> <C-\><C-n><C-w><C-k>
tnoremap <C-l> <C-\><C-n><C-w><C-l>

tnoremap <Esc> <C-\><C-n>
nnoremap <C-q> <C-w><C-l>a<C-c><C-\><C-n><C-w><C-h>
nnoremap <Leader>ll <C-w><C-l>a<C-\><C-n><C-w><C-h>

" Change terminal directory to current vim file
nnoremap <expr> <Leader>cdt move_right."acd ".expand('%:p:h')."\<CR>".esc_term.move_left

" Input parameters
" ================
" cmd: command [string] to run in the right terminal
" fileargtype: sets the type [int] of input argument to append
"     0 = none
"     1 = full file name
"     2 = file name minus extension
function! MakeCmd(cmd, fileargtype)
    let ret = ":w\<CR>\<C-w>\<C-l>a" . a:cmd
    if a:fileargtype == 1
        " filename: init.vim
        let ret = ret . " " . expand('%:t')
    elseif a:fileargtype == 2
        " no extension: init
        let ret = ret . " " . expand('%:r')
    endif
    let ret = ret . "\<CR>"
    return ret
endfunction

let esc_term = "\<C-\>\<C-n>"
let move_left = "\<C-w>\<C-h>"
let move_right = "\<C-w>\<C-l>"
let move_up = "\<C-w>\<C-k>"
let move_down = "\<C-w>\<C-j>"

" Run main executable
nnoremap <expr> <Leader>rr MakeCmd('./main', 0) .esc_term . move_left

nnoremap <Leader><Leader> :w<CR><C-w>la<Up><CR><C-\><C-n><C-w>h

nnoremap <Leader>uu :call LaTeXtoUnicode#Toggle()<CR>

function! ToggleCheck()
    if getline(".")[0:4] == "- [ ]"
        execute "normal! mz0v4lc- [x]\<Esc>`z"
    elseif getline(".")[0:4] == "- [x]"
        execute "normal! mz0v4lc- [ ]\<Esc>`z"
    else
        echo "none"
    endif
endfunction
nnoremap <Leader>tc :call ToggleCheck()<CR>

