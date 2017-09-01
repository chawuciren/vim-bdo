"================================================================================
"= 快捷键
"================================================================================

    "----------------------------------------------------------------------------
    "- 按键定义
    "----------------------------------------------------------------------------

    "----------------------------------------------------------------------------
    "- 编辑
    "----------------------------------------------------------------------------
    let yvt = {}
    let yvt.keymap = {}
    "将jj映射为Esc键"
    "let yvt.keymap["jj"] = {"cmap": "<Esc>l", "imap": "<Esc>"}
    "移动当前行到下一行"
    let yvt.keymap["MoveLineDown"] = {"key": "<C-j>j", "nmap": "ddp", "imap": "<Esc>lddpi"}
    "移动当前行到上一行"
    let yvt.keymap["MoveLineUp"] = {"key": "<C-j>k","nmap": "ddkkp", "imap": "<Esc>lddkkp"}
    "复制当前行"
    let yvt.keymap["CopyCurrentLine"] = {"key": "<C-j>y", "nmap": "yyp", "imap": "<Esc>lyyp"}
    "删除当前行"
    let yvt.keymap["DelCurrentLine"] = {"key": "<C-j>d", "nmap": "dd", "imap": "<Esc>lddi"}
    "在行尾补全句号并另起一行
    let yvt.keymap["EndLineDown"] = {"key": "<C-j>c;", "nmap": "$a;<CR><Esc>", "imap": "<Esc>$a;<CR>"}
    "在行尾补全花括号并另起一行
    let yvt.keymap["EndLineBlockDown"] = {"key": "<C-j>c{", "nmap": "$a {<CR><Esc>", "imap": "<Esc>l$a {<CR>"}
    "增加空行"
    let yvt.keymap["NewEmptyLine"] = {"key": "<C-j>l", "nmap": "o<Esc>", "imap": "<Esc>lo<Esc>"}
    "删除当前单词

    "----------------------------------------------------------------------------
    "- 工具
    "----------------------------------------------------------------------------
    "清除编辑缓存
    let yvt.keymap["CleanUpSwFile"] = {"key": "<C-m>s", "nmap": "\:!find . -name \"*.swp\" \\| xargs rm -fj<CR>:!find . -name \"*.swo\" \\| xargs rm -fj"}
    "开启/关闭Tree控件"
    let yvt.keymap["OpenNerdTree"] = {"key": "<C-m>y", "nmap": ":NERDTreeToggle<CR>"}
    let yvt.keymap["OpenTagbar"] = {"key": "<C-m>u", "nmap": ":TagbarToggle<CR>"}
    "定位到上一个／下一个buffer
    let yvt.keymap["OpenNextBuffer"] = {"key": "<C-m>n", "nmap": ":Bn<CR>"}
    let yvt.keymap["OpenPrevBuffer"] = {"key": "<C-m>b", "nmap": ":Bp<CR>"}


    "----------------------------------------------------------------------------
    "- 快捷键函数
    "----------------------------------------------------------------------------

    function! YVimIntGetKeyCommand(mapindex, mode)
        let s:command = g:yvt["keymap"][a:mapindex][a:mode]
        return s:command
    endfunction

    function! YVimIntRunKeyCommand(mapindex, mode)
        let s:key = g:yvt["keymap"][a:mapindex]["key"]
        let s:command = a:mode . " <C-n> " . s:key
        exe s:command
    endfunction

    function! YVimIntBindKeyMap()
        for mapindex in keys(g:yvt["keymap"])
            let s:key = g:yvt["keymap"][mapindex]["key"]
            let s:keymap = g:yvt["keymap"][mapindex]
            for mode in keys(s:keymap)
                if mode == "nmap"
                    let s:execommand = mode . " " . s:key . " " . YVimIntGetKeyCommand(mapindex, mode) . ":call YVimIntRunKeyCommand('" . mapindex . "','" . mode . "')<CR>"
                    exe s:execommand
                elseif mode == "imap"
                    let s:execommand = mode . " " . s:key . " " . YVimIntGetKeyCommand(mapindex, mode) . "<Esc>:call YVimIntRunKeyCommand('" . mapindex . "','" . mode . "')<CR>a"
                    exe s:execommand
                else
                endif
            endfor
        endfor
    endfunction

    "执行绑定快捷键
    autocmd VimEnter * call YVimIntBindKeyMap()

