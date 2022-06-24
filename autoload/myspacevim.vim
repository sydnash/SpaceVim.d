function! CurDir()
    let l:maxTitleLen = 20
    let l:curdir = getcwd()
    let l:len = strchars(l:curdir, 1)
    if l:len > maxTitleLen
        return '..' . strcharpart(l:curdir, l:len - l:maxTitleLen, l:maxTitleLen)
    endif
    return l:curdir
endfunction

function! SetTerminalTitle()
    let l:title = CurDir()
    if len(l:title) > 0
        let l:title = CurDir()
        " this is the format iTerm2 expects when setting the window title
        let l:args = "\033];".l:title."\007"
        let l:cmd = 'silent !echo -e "'.l:args.'"'
        execute l:cmd
        redraw!
        if has('nvim')
            let &titlestring=l:title
        endif
    endif
endfunction

function! myspacevim#before() abort
    let g:coc_config_home = '$HOME/.SpaceVim.d/'
    " let $NVIM_COC_LOG_LEVEL='all'
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

    if has('nvim')
        nnoremap tgb :te! git blame %<CR> i
        nnoremap tgp :te! git log -p %<CR> i
    endif

    nmap or :GoDebugStart
    nmap ob :GoDebugBreakpoint
    nmap oc :GoDebugContinue
    nmap on :GoDebugNext
    nmap osi :GoDebugStep
    nmap oso :GoDebugStepOut
    nnoremap op :GoDebugPrint 

    noremap qqq :qall!<CR>
    noremap ss :w<CR>
    noremap sq :wq<CR>

    inoremap <C-e> <Esc>$a

    " Set the title of the Terminal to the currently open file
    if has('nvim')
        set title
        lua require('nvim-lsp').disable_nvim_lsp_diagnostics()


        let g:neomake_golangci_lint_maker = {
        \ 'exe': 'golangci-lint',
        \ 'args': ['run', '--out-format=line-number', '--print-issued-lines=false', '--disable=structcheck'],
        \ 'output_stream': 'stdout',
        \ 'append_file': 0,
        \ 'cwd': '%:h',
        \ 'errorformat':
            \ '%f:%l:%c: %m,' .
            \ '%f:%l: %m'
        \ }
    endif
    set t_ts=]1;
    set t_fs=
    call SetTerminalTitle()
    autocmd TermResponse,FocusGained * call SetTerminalTitle()
endfunction
