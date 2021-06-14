command! -nargs=0 FullToHalf :%s/[\uff01-\uff5e]/\=nr2char(char2nr(submatch(0))-65248)/g

function! s:switch_punctuation(match_punction) abort
    let l:punctuations = {
                \ ',':  '、',
                \ '.':  '。',
                \ '。': '.',
                \ '、': ','
                \ }

    return l:punctuations[a:match_punction]
endfunction

command! -nargs=0 PunctuationToggle :%s/[,.、。]/\=s:switch_punctuation(submatch(0))/g
command! -nargs=0 PunctuationEn     :%s/[、。]/\=s:switch_punctuation(submatch(0))/g
command! -nargs=0 PunctuationJa     :%s/[,.]/\=s:switch_punctuation(submatch(0))/g
