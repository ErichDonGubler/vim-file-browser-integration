function! s:RunSilentCommand(command)
	exec 'silent !' . a:command
	redraw!
endfun

let s:file_cmd_info = {
			\ 'command': '',
			\ 'path_prefix': '',
			\ 'path_postfix': '',
			\ 'select_flags': '',
			\ }

if has('win32unix')
	let s:file_cmd_info.command = 'explorer'
	let s:file_cmd_info.path_prefix = '"$(cygpath -w'
	let s:file_cmd_info.path_postfix = ')"'
	let s:file_cmd_info.select_flags = '//select,'
elseif has('unix')
	if has('mac')
		let s:file_cmd_info.command = 'open'
		let s:file_cmd_info.select_flags = '-R'
	else
		let s:file_cmd_info.command = 'xdg-open'
		if exists('nautilus')
			let s:file_cmd_info.select_flags = '-s'
		elseif
			let s:file_cmd_info.select_flags = '--select'
		endif
	endif
else
	let s:file_cmd_info.command = 'explorer'
	let s:file_cmd_info.select_flags = '/select,'
endif

function s:file_cmd_info.open(path) dict
	let l:command = join([self.command, self.path_prefix, a:path, self.path_postfix], ' ')
	call s:RunSilentCommand(l:command)
endfunction

function s:file_cmd_info.select(path) dict
	let l:command = join([self.command, self.select_flags, self.path_prefix, a:path, self.path_postfix], ' ')
	call s:RunSilentCommand(l:command)
endfunction

function! file_browser_integration#OpenFile(path)
	call s:file_cmd_info.open(a:path)
endfun

function! file_browser_integration#SelectFile(path)
	call s:file_cmd_info.select(a:path)
endfun

function! file_browser_integration#GetCurrentBufferPath()
	return shellescape(expand('%'), 1)
endfun

