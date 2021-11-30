function! CurDir()
    let l:maxTitleLen = 20
    let l:curdir = getcwd()
    let l:len = strcharlen(l:curdir)
    if l:len > maxTitleLen
        return '..' . strcharpart(l:curdir, l:len - l:maxTitleLen, l:maxTitleLen)
    endif
    return l:curdir
endfunction

function! SetTerminalTitle()
    let l:titleString = CurDir()
    if len(titleString) > 0
        let l:titlestring = CurDir()
        " this is the format iTerm2 expects when setting the window title
        let l:args = "\033];".l:titlestring."\007"
        let l:cmd = 'silent !echo -e "'.l:args.'"'
        execute l:cmd
        redraw!
    endif
endfunction

function! myspacevim#before() abort
    let g:coc_config_home = '$HOME/.SpaceVim.d/'
    call SpaceVim#custom#SPCGroupName(['u'], '+DebugGolang')
    call SpaceVim#custom#SPC('nnoremap', ['u', 'b'], ':GoDebugBreakpoint', 'add breakpoint', 1)
    call SpaceVim#custom#SPC('nnoremap', ['u', 'r'], ':GoDebugStart', 'start debug current file', 1)
    call SpaceVim#custom#SPC('nnoremap', ['u', 'c'], ':GoDebugContinue', 'continue', 1)
    call SpaceVim#custom#SPC('nnoremap', ['u', 'n'], ':GoDebugNext', 'next', 1)
    call SpaceVim#custom#SPCGroupName(['u', 's'], '+DebugGolang step')
    call SpaceVim#custom#SPC('nnoremap', ['u', 's', 'i'], ':GoDebugStep', 'step in', 1)
    call SpaceVim#custom#SPC('nnoremap', ['u', 's', 'o'], ':GoDebugStepOut', 'step out', 1)

    let g:spacevim_default_custom_leader=';'
    nnoremap <silent><nowait> [SPC] :<c-u>LeaderGuide ' '<CR>
    vnoremap <silent><nowait> [SPC] :<c-u>LeaderGuideVisual ' '<CR>
endfunction

function! myspacevim#after() abort
    nnoremap tgb :!git blame %<CR>
    nnoremap tgp :!git log -p %<CR>
    nnoremap tge :!echo %<CR>
    nnoremap tgg :NERDTreeFind<CR>
    nnoremap tgc :NERDTreeCWD<CR>

    nmap or :GoDebugStart
    nmap ob :GoDebugBreakpoint
    nmap oc :GoDebugContinue
    nmap on :GoDebugNext
    nmap osi :GoDebugStep
    nmap oso :GoDebugStepOut
    nnoremap op :GoDebugPrint 

    noremap qqq :qall!<CR>
    noremap ws :w<CR>
    noremap wq :wq<CR>

    " Set the title of the Terminal to the currently open file
    set t_ts=]1;
    set t_fs=
    autocmd TermResponse,FocusGained,ShellCmdPost * call SetTerminalTitle()
endfunction
