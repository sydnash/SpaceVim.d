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
    call SpaceVim#custom#SPCGroupName(['u'], '+DebugGolang')
    call SpaceVim#custom#SPC('nnoremap', ['u', 'b'], ':GoDebugBreakpoint', 'add breakpoint', 1)
    call SpaceVim#custom#SPC('nnoremap', ['u', 'r'], ':GoDebugStart', 'start debug current file', 1)
    call SpaceVim#custom#SPC('nnoremap', ['u', 'c'], ':GoDebugContinue', 'continue', 1)
    call SpaceVim#custom#SPC('nnoremap', ['u', 'n'], ':GoDebugNext', 'next', 1)
    call SpaceVim#custom#SPCGroupName(['u', 's'], '+DebugGolang step')
    call SpaceVim#custom#SPC('nnoremap', ['u', 's', 'i'], ':GoDebugStep', 'step in', 1)
    call SpaceVim#custom#SPC('nnoremap', ['u', 's', 'o'], ':GoDebugStepOut', 'step out', 1)

    let spacevim_default_custom_leader=';'
    nnoremap <silent><nowait> [SPC] :<c-u>LeaderGuide ' '<CR>
    vnoremap <silent><nowait> [SPC] :<c-u>LeaderGuideVisual ' '<CR>
endfunction

function! myspacevim#after() abort
    nnoremap tgb :!git blame %<CR>
    nnoremap tgp :!git log -p %<CR>
    nnoremap tge :!echo %<CR>
    nnoremap tgg :NERDTreeFind<CR>
    nnoremap tgc :NERDTreeCWD<CR>

    nmap or <Space>ur
    nmap ob <Space>ub
    nmap oc <Space>uc
    nmap on <Space>un
    nmap osi <Space>usi
    nmap oso <Space>uso
    nnoremap op :GoDebugPrint 

    " Set the title of the Terminal to the currently open file
    set t_ts=]1;
    set t_fs=
    autocmd TermResponse,FocusGained,ShellCmdPost * call SetTerminalTitle()
endfunction
