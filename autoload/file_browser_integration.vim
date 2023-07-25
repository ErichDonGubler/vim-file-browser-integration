function! file_browser_integration#RunSilentCommand(command)
	echo 'Running command ' . a:command
	exec 'silent !' . a:command
	redraw!
endfun

function! file_browser_integration#create_commands_base()
	let l:file_command_info = {
				\ 'command': '',
				\ 'path_prefix': '',
				\ 'path_postfix': '',
				\ }

	let l:commands_base = {}
	let l:commands_base.open = deepcopy(l:file_command_info)
	let l:commands_base.select = deepcopy(l:file_command_info)

	function! l:commands_base.open.call(path) dict
		let l:command = join([self.command, self.path_prefix, a:path, self.path_postfix], '')
		call file_browser_integration#RunSilentCommand(l:command)
	endfun

	function! l:commands_base.select.call(path) dict
		let l:command = join([self.command, self.path_prefix, a:path, self.path_postfix], '')
		call file_browser_integration#RunSilentCommand(l:command)
	endfun

	return l:commands_base
endfun

let s:file_browser_commands_base = get(g:, 'file_browser_commands_base', file_browser_integration#create_commands_base())

function! file_browser_integration#get_commands_base()
	return deepcopy(s:file_browser_commands_base)
endfun

function! file_browser_integration#get_default_commands()
	let l:commands = file_browser_integration#get_commands_base()

	if has('win32unix')
		let l:path_conversion_options = {
					\ 'command': 'explorer ',
					\ 'path_prefix': '"$(cygpath -w ',
					\ 'path_postfix': ' )"',
					\ }
		call extend(l:commands.open, l:path_conversion_options)
		call extend(l:commands.select, l:path_conversion_options)
		let l:commands.select.command = 'explorer //select,'
	elseif has('unix')
		let l:commands.open.command = 'xdg-open'
		if has('mac')
			let l:commands.open.command = 'open '
			let l:commands.select.command = 'open -R '
		elseif executable('nautilus')
			let l:commands.select.command = 'nautilus '
			let l:commands.select.flags = 'nautilus --select '
		endif
	else
		let l:commands.open.command = 'explorer '
		let l:commands.select.command = 'explorer /select,'
	endif

	return l:commands
endfun

let g:file_browser_commands = get(g:, 'file_browser_commands', file_browser_integration#get_default_commands())

function! file_browser_integration#OpenFile(path)
	call g:file_browser_commands.open.call(a:path)
endfun

function! file_browser_integration#SelectFile(path)
	call g:file_browser_commands.select.call(a:path)
endfun

function! file_browser_integration#GetCurrentBufferPath()
	return shellescape(expand('%'), 1)
endfun

