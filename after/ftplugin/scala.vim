" Vim filetype plugin file
" Language:             Scala
" Maintainer:           Derek Wyatt
" URL:                  https://github.com/derekwyatt/vim-scala
" License:              Same as Vim
" Last Change:          11 August 2021
" ----------------------------------------------------------------------------

if exists('b:did_ftplugin') || &cp
  finish
endif
let b:did_ftplugin = 1

setlocal formatoptions-=to formatoptions+=crqnlj

" Just like c.vim, but additionally doesn't wrap text onto /** line when
" formatting. Doesn't bungle bulleted lists when formatting.
if get(g:, 'scala_scaladoc_indent', 0)
  setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s2:/**,mb:*,ex:*/,s1:/*,mb:*,ex:*/,://
else
  setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/**,mb:*,ex:*/,s1:/*,mb:*,ex:*/,://
endif
setlocal commentstring=//\ %s

setlocal shiftwidth=2 softtabstop=2 expandtab shiftround

setlocal include=^\\s*import
setlocal includeexpr=substitute(v:fname,'\\.','/','g')

setlocal path+=src/main/scala,src/test/scala
setlocal suffixesadd=.scala

" vim:set sw=2 sts=2 ts=8 et:
