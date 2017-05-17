# vim-file-browser-integration

This plugin integrates Vim with your graphical file browser by providing commands and functions to open and select files in your graphical file browser.

## Installation

My favorite way is with VimPlug:

```
Plug 'ErichDonGubler/vim-file-browser-integration'
```

## Usage

For plugin/library writers, several useful functions are provided out of the box:
* `file_browser_integration#OpenFile`: opens a filepath, similar to a double-click in your file browser application.
* `file_browser_integration#SelectFile`: opens your file browser to the location of the filepath given, with the file itself selected.

End-users of this particular plugin will probably be interested in these convenience `:command`s:
* `:SelectCurrentFile`: shows the current buffer in your file browser
* `:OpenCWD`: shows the current working directory in your file browser
* `:OpenCurrentBuffer`: opens the current buffer using your file browser

No bindings to these commands are provided by default. I'd recommend something like:

```vim
nnoremap <Leader>e :SelectCurrentFile<CR>
nnoremap <Leader>x :OpenCurrentFile<CR>
nnoremap <Leader>E :OpenCWD<CR>
```

### Configuration

TODO.

However, if you actually DO need to change the configuration in order to use this plugin, realize that you should probably submit a bug! :) The entire point of this plugin/library is to encapsulate file opening and selection in a cross-platform way.

