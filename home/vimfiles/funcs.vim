" Function to toggle the quickfix list
"----------------------------------------------------------------------
function! ToggleQuickfix()
	" Check if the quickfix window is open
	if len(filter(getwininfo(), 'v:val.quickfix'))
		" Close the quickfix window
		cclose
	else
		" Open the quickfix window
		copen
	endif
endfunction

"----------------------------------------------------------------------

" Function to perform search and replace in all files listed in the quickfix list
"----------------------------------------------------------------------
function! CfdoReplace()
	" Prompt for search pattern
	let l:search_pattern = input('Search pattern: ')
	if empty(l:search_pattern)
		echo "No search pattern provided"
		return
	endif

	" Prompt for replacement pattern
	let l:replace_pattern = input('Replace "' . l:search_pattern . '" with: ')
	if empty(l:replace_pattern)
		echo "No replacement pattern provided"
		return
	endif

	" Execute search and replace in all files listed in the quickfix list
	execute 'cfdo %s/' . l:search_pattern . '/' . l:replace_pattern . '/gci'
endfunction

"----------------------------------------------------------------------
