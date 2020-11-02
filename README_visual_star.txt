==============================================================================
INTERFACE					*visualstar-interface*

------------------------------------------------------------------------------
KEY MAPPINGS					*visualstar-key-mappings*

<Plug>(visualstar-*)			*<Plug>(visualstar-star)* *v_star*
			Search forward for the [count]'th occurrence of
			selection text in |Visual-mode| nearest to the cursor.
			If the character of head of selection text is
			'iskeyword' character, and outside of selection area
			is not 'iskeyword' character, "\<" is appended to the
			head of search word like same as |star|.
			The tail is also similar.

<Plug>(visualstar-#)			*<Plug>(visualstar-#)* *v_#*
			Same as |<Plug>(visualstar-star)|, but search
			backward.

<Plug>(visualstar-g*)			*<Plug>(visualstar-gstar)* *v_gstar*
			Like |<Plug>(visualstar-star)|, but don't put "\<" and
			"\>" around the word.

<Plug>(visualstar-g#)			*<Plug>(visualstar-g#)* *v_g#*
			Like |<Plug>(visualstar-#)|, but don't put "\<" and
			"\>" around the word.

In |Normal-mode| and |Operator-pending-mode|, the following key mappings will
be also defined for convenience.

{lhs}				{rhs}
------------------------	------
<Plug>(visualstar-*)		*
<Plug>(visualstar-#)		#
<Plug>(visualstar-g*)		g*
<Plug>(visualstar-g#)		g#


					*g:visualstar_no_default_key_mappings*
The following key mappings will be also available in |Visual-mode| unless
|g:visualstar_no_default_key_mappings| is defined:

{lhs}		{rhs}
--------	---------------------
*		<Plug>(visualstar-*)
<kMultiply>	<Plug>(visualstar-*)
<S-LeftMouse>	<Plug>(visualstar-*)
#		<Plug>(visualstar-#)
g*		<Plug>(visualstar-g*)
g<kMultiply>	<Plug>(visualstar-g*)
g<S-LeftMouse>	<Plug>(visualstar-g*)
g#		<Plug>(visualstar-g#)



==============================================================================
SETTINGS					*visualstar-settings*


g:visualstar_extra_commands			*g:visualstar_extra_commands*
	In case you want to run extra commands when searching, you can set
	this variable to a key sequence.
	For example, to center the search in the window and open enough folds,
	you can set the following variable.
>
	let g:visualstar_extra_commands = 'zzzv'
<


==============================================================================
EXAMPLES					*visualstar-examples*

Search the text, but cursor don't move to next match. >
	map * <Plug>(visualstar-*)N
	map # <Plug>(visualstar-#)N
If you map N to something, you must create and use a secondary key mapping. >
	noremap <Plug>N N
	map * <Plug>(visualstar-*)<Plug>N
	map # <Plug>(visualstar-#)<Plug>N
