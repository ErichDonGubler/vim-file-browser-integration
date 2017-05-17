" let g:nerdtree_plugin_open_cmd = s:file_cmd_info.open;
:command! OpenCurrentFile :call file_browser_integration#OpenFile(file_browser_integration#GetCurrentBufferPath())
:command! OpenCWD :call file_browser_integration#OpenFile('.')
:command! SelectCurrentFile :call file_browser_integration#SelectFile(file_browser_integration#GetCurrentBufferPath())

