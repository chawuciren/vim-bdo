"Close other buf

command! Bdo call <SID>BdoCloseOthers()
command! -nargs=1 Bd call <SID>BdoCloseBuffer(<f-args>)

function! <SID>BdoCloseOthers()
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

function! <SID>BdoCloseBuffer(num)
    let l:currentBufNum   = bufnr("%")
    let l:lastBufNum = bufnr("#")

    if buflisted(a:num)
        if a:num==l:currentBufNum
            execute("b".l:lastBufNum)
        else
        endif

        execute("bdelete ".i)
    endif
endfunction
