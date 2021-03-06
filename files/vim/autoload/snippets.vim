fun! SnippetUcFirst(str)
  return substitute(a:str, '\(^[a-z]\)', '\U\1', '')
endf

fun! SnippetExtendClass(str)
  if [[ -z str ]]
  then
    return " extends $str" ;
  else
    return "";
  fi
endf

function! Snippet_Camelcase(s)
  "upcase the first letter
  let toReturn = substitute(a:s, '^\(.\)', '\=toupper(submatch(1))','')
  "turn all '_x' into 'X'
  return substitute(toReturn, '_\(.\)','\=toupper(submatch(1))', 'g')
endfunction

function! Snippet_Underscore(s)
  "down the first letter
  let toReturn = substitute(a:s, '^\(.\)', '\=tolower(submatch(1))', '')
  "turn all 'X' into '_x'
  return substitute(toReturn, '\([A-Z]\)', '\=tolower("_".submatch(1))', 'g')
endfunction
