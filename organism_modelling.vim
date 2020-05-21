
"set python syntax highlighting for organism files.
au BufRead,BufNewFile *.model set filetype=python
au BufRead,BufNewFile *.init set filetype=python
au BufRead,BufNewFile *.rk set filetype=python
au BufRead,BufNewFile *.rkT set filetype=python
au BufRead,BufNewFile *.cvodeT set filetype=python
au BufRead,BufNewFile *.cvode set filetype=python
au BufRead,BufNewFile *.solver set filetype=python
au BufRead,BufNewFile *.est set filetype=python
au BufRead,BufNewFile *.opt set filetype=python
au BufRead,BufNewFile *.cost set filetype=python
au BufRead,BufNewFile *.costfile set filetype=python


" ================ Modelling =============
command! ModelIncrementP let i=0 | %g/p_/s/p_[0-9]*/\='p_'.i / |let i=i+1
"command! ModelOptParam let i=0 | %g/p_/s/^/\=i.' 0.1 10 # '/ | let i+=1
command! ModelWindowOpen source ~/.vim/scripts/modellingWindows.vim
command! ModelOptParam source ~/.vim/scripts/modellingOptParam.vim


" ================ Writing =============
function! LatexClawusAbbreviations()
  " map abbreviations
  call IMAP(' wus ', ' \ac{wus} ', 'tex')
  call IMAP(' gwus ', ' \textit{\ac{wus}} ', 'tex')
  call IMAP(' c3 ', ' \ac{c3} ', 'tex')
  call IMAP(' gc3 ', ' \textit{\ac{c3}} ', 'tex')
  call IMAP('clv3', '\ac{c3}', 'tex')
  call IMAP('clv1', '\ac{c1}', 'tex')
  call IMAP('c1', '\ac{c1}', 'tex')
  call IMAP('crn', '\ac{crn}', 'tex')
  call IMAP(' lird ', ' \ac{lird} ', 'tex')
  call IMAP(' boa ', ' \ac{boa} ', 'tex')
  call IMAP(' pboa ', ' \acp{boa} ', 'tex')
  call IMAP(' sam ', ' \ac{sam} ', 'tex')
  "call IMAP('sam', '\ac{sam}', 'tex')
  "call IMAP('oc', '\ac{oc}', 'tex')
  "call IMAP('cz', '\ac{cz}', 'tex')
  "call IMAP('pm', '\ac{pm}', 'tex')
endfunction
com! LatexClawus call LatexClawusAbbreviations()
