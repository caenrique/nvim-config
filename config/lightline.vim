function! LightlineFilename()
  return expand('%')
endfunction

function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

function! s:hideIfSmallWindow(conten)
  return winwidth(0) > 120 ? a:conten : ''
endfunction

function CurrentWorkingDirectory()
  let l:current_dir = substitute(system("print -rD $PWD"), '\n\+$', '', '')
  if winwidth(0) > 140
    return l:current_dir
  elseif winwidth(0) > 125
    return pathshorten(l:current_dir)
  elseif winwidth(0) > 95
    return get(reverse(split(l:current_dir, '/')), 0)
  else
    return ''
endfunction

function GitBranch()
  return s:hideIfSmallWindow(fugitive#head())
endfunction

function GetWindowNumber()
  return winnr()
endfunction

function CocStatus()
  return s:hideIfSmallWindow(coc#status())
endfunction

let g:lightline = {
\  'active': {
\    'left': [['mode', 'paste'], ['gitbranch'], ['readonly', 'filename', 'currentfunction', 'modified']],
\    'right': [['lineinfo'], ['percent'], ['coc-status', 'current_working_directory']]
\  },
\  'inactive': {
\    'left': [['filename']],
\    'right': [['widnow_number']]
\  },
\  'component_function': {
\    'gitbranch': 'GitBranch',
\    'coc-status': 'CocStatus',
\    'currentfunction': 'CocCurrentFunction',
\    'current_working_directory': 'CurrentWorkingDirectory',
\    'widnow_number': 'GetWindowNumber'
\  },
\  'component': {
\    'lineinfo': '%3l:%-2v%<',
\    'percent': '%3p%%%<'
\  },
\  'enable': { 'tabline': 0 },
\  'colorscheme' : 'onedark'
\}
