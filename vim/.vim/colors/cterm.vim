let g:colors_name = "cterm"

function! Highlight(foregroundNR, backgroundNR)
    let ctermfgNR = (a:foregroundNR + 1) % 17 - 1
    let ctermbgNR = (a:backgroundNR + 1) % 17 - 1
    let colorNameArray = [
    \    'DBlack', 'DRed', 'DGreen', 'DYellow', 'DBlue', 'DMagenta',
    \    'DCyan', 'DWhite', 'LBlack', 'LRed', 'LGreen', 'LYellow',
    \    'LBlue', 'LMagenta', 'LCyan', 'LWhite', 'NONE' 
    \]
    let foregroundColorName = colorNameArray[ctermfgNR]
    let backgroundColorName = colorNameArray[ctermbgNR]
    if ctermfgNR == -1
        let ctermfgNR = 'NONE'
    endif
    if ctermbgNR == -1
        let ctermbgNR = 'NONE'
    endif
    for i in range(32)
        let highlightNameFragments = ['Cterm']
        if foregroundColorName != 'NONE'
            call add(highlightNameFragments, foregroundColorName)
        endif
        if backgroundColorName != 'NONE'
            call add(highlightNameFragments, backgroundColorName)
        endif
        let ctermStringFragments = [[], []]
        if float2nr(floor(i / pow(2, 4))) % 2
            call add(ctermStringFragments[0], 'bold,')
            call add(ctermStringFragments[1], 'B')
        endif
        if float2nr(floor(i / pow(2, 3))) % 2
            call add(ctermStringFragments[0], 'italic,')
            call add(ctermStringFragments[1], 'I')
        endif
        if float2nr(floor(i / pow(2, 2))) % 2
            call add(ctermStringFragments[0], 'reverse,')
            call add(ctermStringFragments[1], 'R')
        endif
        if float2nr(floor(i / pow(2, 1))) % 2
            call add(ctermStringFragments[0], 'strikethrough,')
            call add(ctermStringFragments[1], 'S')
        endif
        if float2nr(floor(i / pow(2, 0))) % 2
            call add(ctermStringFragments[0], 'underline,')
            call add(ctermStringFragments[1], 'U')
        endif
        let ctermString = join(ctermStringFragments[0], '')
        if ctermString == ''
            let ctermString = 'NONE'
        endif
        let ctermHighlightNameFragment = join(ctermStringFragments[1], '')
        if ctermHighlightNameFragment != ''
            call add(highlightNameFragments, ctermHighlightNameFragment)
        endif
        let highlightName = join(highlightNameFragments, '_')
        let highlightStringFragments = [
        \    'highlight ', highlightName, ' ctermfg=', ctermfgNR, 
        \    ' ctermbg=', ctermbgNR, ' cterm=', ctermString
        \]
        let highlightString = join(highlightStringFragments, '')
        execute highlightString
    endfor
endfunction

for i in range(-1, 15)
    call Highlight(i, -1)
    "for j in range(-1, 15)
    "    call Highlight(i, j)
    "endfor
endfor

" Generic statement
hi! link Statement Cterm_LRed
" if, then, else, endif, swicth, etc.
hi! link Conditional Cterm_LRed
" for, do, while, etc.
hi! link Repeat Cterm_LRed
" case, default, etc.
hi! link Label Cterm_LRed
" try, catch, throw
hi! link Exception Cterm_LRed
" sizeof, "+", "*", etc.
hi! link Operator LCyan
" Any other keyword
hi! link Keyword Cterm_LRed

" Variable name
hi! link Identifier Cterm_LBlue
" Function name
hi! link Function Cterm_LGreen_B

" Generic preprocessor
hi! link PreProc Cterm_LCyan
" Preprocessor #include
hi! link Include Cterm_LCyan
" Preprocessor #define
hi! link Define Cterm_LCyan
" Same as Define
hi! link Macro Cterm_LCyan
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit Cterm_LCyan

" Generic constant
hi! link Constant Cterm_LMagenta
" Character constant: 'c', '/n'
hi! link Character Cterm_LMagenta
" Boolean constant: TRUE, false
hi! link Boolean Cterm_LMagenta
" Number constant: 234, 0xff
hi! link Number Cterm_LMagenta
" Floating point constant: 2.3e10
hi! link Float Cterm_LMagenta

" Generic type
hi! link Type Cterm_LYellow
" static, register, volatile, etc
hi! link StorageClass Cterm_LYellow
" struct, union, enum, etc.
hi! link Structure Cterm_LCyan
" typedef
hi! link Typedef Cterm_LYellow

hi! link Comment Cterm_LBlack
