function! CurDir()
    let maxTitleLen = 20
    let curdir = getcwd()
    let len = strcharlen(curdir)
    if len > maxTitleLen
        return '..' . strcharpart(curdir, len - maxTitleLen, maxTitleLen)
    endif
    return curdir
endfunction

function! SetTerminalTitle()
    let titleString = CurDir()
    if len(titleString) > 0
        let &titlestring = CurDir()
        " this is the format iTerm2 expects when setting the window title
        let args = "\033];".&titlestring."\007"
        let cmd = 'silent !echo -e "'.args.'"'
        execute cmd
        redraw!
    endif
endfunction

function! myspacevim#before() abort
endfunction

function! myspacevim#after() abort
    nmap tgb :!git blame %<CR>
    nmap tgp :!git log -p %<CR>
    nmap tge :!echo %<CR>

    " Set the title of the Terminal to the currently open file
    set t_ts=]1;
    set t_fs=
    call SetTerminalTitle()
    " autocmd BufEnter * call SetTerminalTitle()

    call SpaceVim#custom#SPCGroupName(['O'], '+TestGroup')
    call SpaceVim#custom#SPC('nore', ['O', 'o'], 'echom 1', 'echomessage 1', 1)
endfunction
