"关闭其他标签

command! Bp call BdoOpenPrevBuffer()
command! Bn call BdoOpenNextBuffer()
command! Bdo call BdoCloseOthers()
command! Bdc call BdoCloseCurrent()
command! -nargs=1 Bd call BdoCloseBuffer(<f-args>)

function! BdoOpenPrevBuffer()
    execute("bp!")
endfunction

function! BdoOpenNextBuffer()
    execute("bn!")
endfunction

function! BdoCloseOthers()
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

function! BdoCloseBuffer(num)
    let l:currentBufNum = bufnr("%")
    let l:preBufNum = bufnr("#")

    if l:preBufNum==-1&&a:num==l:currentBufNum
        execute(":e empty")
        execute("bdelete " . a:num)
        echo "Can not close current buffer!"
    elseif a:num==l:currentBufNum
        execute("b".l:preBufNum)
        execute("bdelete " . l:currentBufNum)
    else
        execute("bdelete " . l:num)
    endif
endfunction

function! BdoCloseCurrent()
    let l:currentBufNum = bufnr("%")
    let l:preBufNum = bufnr("#")

    if l:preBufNum==-1&&a:num==l:currentBufNum
        execute(":e empty")
        execute("bdelete " . l:currentBufNum)
        echo "Buffer list is empty!"
    else
        execute("b".l:preBufNum)
        execute("bdelete " . l:currentBufNum)
    endif
endfunction
