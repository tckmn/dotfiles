function! Local()
    let l:path = expand('%:p')
    let l:path = l:path ? l:path : getcwd()

    let p = '/home/tckmn/code/py/kipfa'
    if l:path =~ p
        let &l:path = p.'/src/**/*,.,,'
    endif

    if l:path =~ '/home/tckmn/code/sh/dotfiles/.local/share/plover'
        au! BufWritePost dict silent !./convert.rb
    endif

endfunction

au! VimEnter,BufReadPost,BufNewFile * call Local()
