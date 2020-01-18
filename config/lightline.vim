function! LightlineFilename()
  return expand('%')
endfunction

let g:lightline = {
\ 'colorscheme': 'onedark',
\ 'active': {
\ 	'left': [ [ 'mode', 'paste' ], [ 'gitbranch' ], [ 'readonly', 'filename', 'modified' ] ],
\	'right': [ [ 'lineinfo' ], [ 'percent' ], ['coc-status'] ]
\ },
\'inactive': {
\	'left': [ [ 'filename' ] ],
\	'right': [ ]
\ },
\ 'component_function': {
\   'gitbranch': 'fugitive#head',
\   'coc-status': 'coc#status'
\ }
\ }

