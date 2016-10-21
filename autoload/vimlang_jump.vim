function vimlang_jump#InitCommand()
    noremap <buffer> <C-]> :call <SID>JumpVimDefinition()<CR>
endfunction

function s:JumpVimDefinition()
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
            let line = search(l:func_name)
            if line > 0
                normal zt
            endif
        endif
    endif
endfunction
