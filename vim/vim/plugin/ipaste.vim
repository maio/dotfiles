nmap P :call <SID>pasteAbove()<CR>
nmap p :call <SID>pasteBelow()<CR>

fun! s:pasteAbove()
    let indent = s:detectCorrectIndent("O")
    exe "norm! P"
    call s:fixPasteIndent(indent)
endfun

fun! s:pasteBelow()
    let indent = s:detectCorrectIndent("o")
    exe "norm! p"
    call s:fixPasteIndent(indent)
endfun

fun! s:detectCorrectIndent( key )
    exe "norm! " . a:key . "here"
    let indent = s:getIndent(getline('.')) - s:getIndent(getreg())
    exe "norm! u"
    return indent
endfun

fun! s:getIndent(string)
    return match(a:string, "\\S") / &sw
endfun

fun! s:fixPasteIndent( indentDiff )
    if a:indentDiff == 0
        return
    endif
    let direction = a:indentDiff > 0 ? ">" : "<"
    exe "norm! `[v`]" . abs(a:indentDiff) . direction
endfun

