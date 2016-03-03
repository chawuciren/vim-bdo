"Close other buf
"Use commad ":Bdo" or key "bdo"

command! Bdo call <SID>BufCloseOthers()
map bdo :Bdo<CR>

function! <SID>BufCloseOthers()
    let l:currentBufNum   = bufnr("%")
    let l:alternateBufNum = bufnr("#")
    for i in range(1,bufnr("$"))
        if buflisted(i)
            if i!=l:currentBufNum
                execute("bdelete ".i)
            endif
        endif
    endfor
endfunction
