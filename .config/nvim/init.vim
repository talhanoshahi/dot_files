let mapleader =","
syntax on
filetype plugin indent on

set title
set clipboard=unnamed
set ruler
set encoding=utf-8 
set cursorline
set noruler
syntax on
set wildmode=longest,list,full

"set hidden

set tabstop=8 softtabstop=4
set shiftwidth=4
"set autoindent
set smartindent 
set cindent
set relativenumber
set nu
set nowrap

set colorcolumn=100

set nocompatible
filetype on

call plug#begin("~/.config/nvim/plugged")

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'itchyny/vim-cursorword'
" Plug 'ap/vim-css-color'
Plug 'machakann/vim-highlightedyank'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'bfrg/vim-cpp-modern'
" Plug 'chrisbra/csv.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'andymass/vim-matchup'
" Plug 'rakr/vim-one'
Plug 'cpiger/NeoDebug'
Plug 'tpope/vim-surround'
" Plug 'jceb/vim-orgmode'
Plug 'FooSoft/vim-argwrap'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'Yggdroot/indentLine'

call plug#end()

" _____________________________________________________________________________________________

" vim-one theme
"
if (empty($TMUX))
    if (has("nvim"))
	"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
	set termguicolors
    endif
endif

let g:one_allow_italics = 1
" colorscheme one
set background=dark

" _____________________________________________________________________________________________
"
" Nerd tree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
if has('nvim')
    let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
else
    let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
endif
"
" _____________________________________________________________________________________________
"
" _____________________________________________________________________________________________
"
nnoremap <silent> <leader>a :ArgWrap<CR>
"
" _____________________________________________________________________________________________
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
	    \ coc#pum#visible() ? coc#pum#next(1) :
	    \ CheckBackspace() ? "\<Tab>" :
	    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
	    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
	call CocActionAsync('doHover')
    else
	call feedkeys('K', 'in')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s)
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Octave syntax
au! BufRead,BufNewFile *.m,*.oct set filetype=octave

" _______________________________________________________________________________________________
"
" Devhelp Integration copied from https://gitlab.gnome.org/GNOME/devhelp/blob/6e0a78bce8be3e9b2a9e4454b9b11f80531a6f91/plugins/devhelp.vim

" To enable devhelp search:
" let g:devhelpSearch=1
"
" To enable devhelp assistant:
" let g:devhelpAssistant=1
"
" To change the update delay (e.g. to 150ms):
" set updatetime=150
"
" To change the search key (e.g. to F5):
" let g:devhelpSearchKey = '<F5>'
"
" To change the length (e.g. to 5 characters) before a word becomes
" relevant:
"   let g:devhelpWordLength = 5

if !exists ('g:devhelpSearchKey')
    let g:devhelpSearchKey = '<F7>'
endif
if !exists ('g:devhelpWordLength')
    let g:devhelpWordLength = 5
endif

" Variable for remembering the last assistant word
let s:lastWord = ''

function! GetCursorWord ()
    " Try to get the word below the cursor
    let s:word = expand ('<cword>')

    " If that's empty, try to use the word before the cursor
    if empty (s:word)
	let s:before = getline  ('.')[0 : getpos ('.')[2]-1]
	let s:start  = match    (s:before, '\(\w*\)$')
	let s:end    = matchend (s:before, '\(\w*\)$')
	let s:word   = s:before[s:start : s:end]
	end

	return s:word
    endfunction

    function! DevhelpUpdate (flag)
	try
	    " Get word below or before cursor
	    let s:word = GetCursorWord ()

	    if a:flag == 'a'
		" Update Devhelp assistant window
		if s:lastWord != s:word && strlen (s:word) > g:devhelpWordLength
		    " Update Devhelp
		    call system ('devhelp -a '.s:word.' &')

		    " Remember the word for next time
		    let s:lastWord = s:word
		    end
		else
		    " Update devhelp search window. Since the user intentionally
		    " pressed the search key, the word is not checked for its
		    " length or whether it's new
		    call system ('devhelp -s '.s:word.' &')
		    end
		catch
		endtry
	    endfunction

	    function! DevhelpUpdateI (flag)
		" Use normal update function
		call DevhelpUpdate (a:flag)

		if col ('.') == len (getline ('.'))
		    " Start appening if the cursor at the end of the line
		    startinsert!
		else
		    " Otherwise move the cursor to the right and start inserting.
		    " This is required because <ESC> moves the cursor to the left
		    let s:pos = getpos ('.')
		    let s:pos[2] += 1
		    call setpos ('.', s:pos)
		    startinsert
		endif
	    endfunction

	    if exists ('g:devhelpSearch') && g:devhelpSearch
		" Update the main Devhelp window when the search key is pressed
		exec 'nmap '.g:devhelpSearchKey.' :call DevhelpUpdate("s")<CR>'
		exec 'imap '.g:devhelpSearchKey.' <ESC>:call DevhelpUpdateI("s")<CR>'
	    endif

	    if exists ('g:devhelpAssistant') && g:devhelpAssistant
		" Update the assistant window if the user hasn't pressed a key for a
		" while. See :help updatetime for how to change this delay
		au! CursorHold  * nested call DevhelpUpdate('a')
		au! CursorHoldI * nested call DevhelpUpdate('a')
	    endif

	    " _______________________________________________________________________________________________
	    "
	    " Function for toggling the bottom statusbar:
	    let s:hidden_all = 0
	    function! ToggleHiddenAll()
		if s:hidden_all  == 0
		    let s:hidden_all = 1
		    set noshowmode
		    set noruler
		    set laststatus=0
		    set noshowcmd
		else
		    let s:hidden_all = 0
		    set showmode
		    set ruler
		    set laststatus=2
		    set showcmd
		endif
	    endfunction
	    nnoremap <leader>h :call ToggleHiddenAll()<CR>
