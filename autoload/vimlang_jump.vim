function! vimlang_jump#InitCommand()
    noremap <buffer> <C-]> :call <SID>JumpVimDefinition()<CR>
endfunction

function s:JumpVimDefinition()
    " TODO 对于 <SID>FuncName(),s:FuncName() 应该如何定位？
    " 首先，对于s:FuncName的函数调用，是无法通过expand('<cword>')获取全名的。
    " 另外，如果要同时针对s:name,g:name定位的话，还无法简单地判断，当前需要定位的标识符，
    " 到底是函数，还是变量——也许，使用tags是一个解决办法。
    " 但是，仅针对vim脚步的tags文件，可能会对你当前工作中的跳转，造成干扰。
    let func_name = expand('<cword>')
    let path = fnamemodify(substitute(l:func_name, '#', '/', 'g'), ':h')
    if !empty(path)
        let path = 'autoload/' . path . '.vim'
        let path_list = split(globpath(&rtp, path), "\n")
        if len(path_list)
            let path = path_list[0]
        endif
        if filereadable(path)
            silent execute 'new ' . path
            let line = search('^\s*func\%(tion\)\=!\=\s*'.l:func_name.'\>')
            if line > 0
                normal! zt
            endif
        endif
    endif
endfunction
