" Rename tabs to show tab number.
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    " set up tab labels with tab number, buffer name, number of windows
    function! GuiTabLabel()
      let label = ''
      let bufnrlist = tabpagebuflist(v:lnum)
      " Add '+' if one of the buffers in the tab page is modified
      for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
          let label = '+'
          break
        endif
      endfor
      " Append the tab number
      let label .= v:lnum.': '
      " Append the buffer name
      let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
      if name == ''
        " give a name to no-name documents
        if &buftype=='quickfix'
          let name = '[Quickfix List]'
        else
          let name = '[No Name]'
        endif
      else
        " get only the file name
        let name = fnamemodify(name,":t")
      endif
      let label .= name
      " Append the number of windows in the tab page
      "let wincount = tabpagewinnr(v:lnum, '$')
      return label " . '  [' . wincount . ']'
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set guitablabel=%{GuiTabLabel()}
    set showtabline=1
    highlight link TabNum Special
endif
