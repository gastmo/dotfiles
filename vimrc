" .vimrc
 
" general {{{
"------------------------------------------------------
set nocompatible

" watch for changes then auto source vimrc
" http://stackoverflow.com/a/2403926
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

"}}}
" plugins {{{1
"------------------------------------------------------

" ultisnips {{{2

" Trigger configuration. 
" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"}}}
" vimwiki - Personal Wiki for Vim {{{2
" https://github.com/vimwiki/vimwiki
" helppage -> :h vimwiki-syntax 
" vimwiki with markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" vim-instant-markdown - Instant Markdown previews from Vim {{{2
" https://github.com/suan/vim-instant-markdown
let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>

" vim-coffee-script {{{2
" https://github.com/kchmck/vim-coffee-script
"}}}


syntax enable
filetype plugin indent on 
"}}}
" moving around, searching and patterns {{{
"------------------------------------------------------
" move thru word wrapped line
nnoremap k gk
nnoremap j gj

" toggle line numbers
nmap <C-N><C-N> :set invnumber<CR>

" Go to beginning or end of line
noremap H ^
noremap L $

" keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" clear matching after search
noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

"}}}
" tags {{{
"------------------------------------------------------
"}}}
" displaying text {{{
"------------------------------------------------------
" unix or dos file format
" http://stackoverflow.com/a/82743
map <leader>unix :set fileformat=unix<CR>
map <leader>dos :set fileformat=dos<CR>
"}}}
" syntax, highlighting and spelling {{{
"------------------------------------------------------
"syntax on
"}}}
" multiple windows {{{
"------------------------------------------------------
"}}}
" multiple tab pages {{{
"------------------------------------------------------
"}}}
" terminal {{{
"------------------------------------------------------
"}}}
" using the mouse {{{
"------------------------------------------------------
"}}}
" printing {{{
"------------------------------------------------------
"}}}
" messages and info {{{
"------------------------------------------------------
"}}}
" selecting text {{{
"------------------------------------------------------
" copy or paste from X11 clipboard
" http://vim.wikia.com/wiki/GNU/Linux_clipboard_copy/paste_with_xclip
vmap <leader>xyy :!xclip -f -sel clip<CR>
map <leader>xpp mz:-1r !xclip -o -sel clip<CR>`z
"}}}
" editing text {{{
"------------------------------------------------------
"}}}
" tabs and indenting {{{
"------------------------------------------------------
set autoindent
set smartindent

" Set tabstop, softtabstop and shiftwidth to the same value
" http://vimcasts.org/episodes/tabs-and-spaces/
" useage; :Stab
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

let g:indentguides_state = 0
function! IndentGuides() " {{{
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction " }}}
hi def IndentGuides guibg=#303030
nnoremap <leader>I :call IndentGuides()<cr>

"}}}
" folding {{{
"------------------------------------------------------
" enable folding; http://vim.wikia.com/wiki/Folding
set foldmethod=marker

" fold color
hi Folded cterm=bold ctermfg=DarkBlue ctermbg=none
hi FoldColumn cterm=bold ctermfg=DarkBlue ctermbg=none

"refocus folds; close any other fold except the one that you are on
nnoremap ,z zMzvzz


"}}}
" diff mode {{{
"------------------------------------------------------
"}}}
" mapping {{{
"------------------------------------------------------
let mapleader=" "

map <leader>? :verbose map <CR><CR>

" move between matching opening and ending code; example { code }
map <tab> %

" quicker command line mode hotkey
" nmap ; :

" reload vimrc manually
map <leader>reload :source ~/.vimrc<CR>

" Don't move on *
" nnoremap * *<c-o>

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" Clean trailing whitespace
nnoremap <leader>W mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Change case
" inoremap <C-u> <esc>mzgUiw`za
inoremap <C-u> <esc>mzgUaw`za

" Emacs bindings in command line mode
" cnoremap <c-a> <home>
" cnoremap <c-e> <end>

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_


" color highlight line
"set cul                                         " highlight current line
"hi CursorLine term=none cterm=none ctermbg=8    " adjust color


" reopen file where you left off at
" http://stackoverflow.com/questions/774560
" make sure to have permissions to ~/.viminfo if it doesnt work
" sudo chown user:group ~/.viminfo
" where user is your username and group is often the same as your username
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

"}}}
" reading and writing files {{{
"------------------------------------------------------
"}}}
" the swap file {{{
"------------------------------------------------------
"}}}
" command line editing {{{
"------------------------------------------------------
" write file if you forgot to give it sudo permission
" tutorial video: http://www.youtube.com/watch?v=C6xqO4Z1nIo
map <leader>sudo :w !sudo tee % <CR><CR>
"}}}
" executing external commands {{{
"------------------------------------------------------


" open with locate or find command
" tutorial video: https://www.youtube.com/watch?v=X0KPl5O006M
map <leader>o :exec '!xdg-open ' . shellescape(getline('.')) <CR><CR>

map <leader>mp :exec '!mplayer ' . shellescape(getline('.')) <CR><CR>

" stream justin tv ..etc
map <leader>ls :exec '!livestreamer -p mplayer ' . shellescape(getline('.')) . 'best' <CR><CR>

" watch streaming porn
map <leader>p :exec '!mplayer $(youtube-dl -g ' . shellescape(getline('.')) . ')' <CR><CR>

" download videos/files
map <leader>yt :exec '!cd ~/Downloads; youtube-dl ' . shellescape(getline('.')) <CR><CR>
map <leader>wg :exec '!cd ~/Downloads; wget -N -c ' . shellescape(getline('.')) <CR><CR>


"}}}
" running make and jumping to errors {{{
"------------------------------------------------------
"}}}
" language specific {{{
"------------------------------------------------------
"}}}
" multi-byte characters {{{
"------------------------------------------------------
"}}}
" various {{{
"------------------------------------------------------
"}}}
" bookmarks {{{
"------------------------------------------------------
" save bookmarks on exit
" http://stackoverflow.com/a/8958141
" Uppercase or numeric marks will be remember.
" Lowercase marks are temporary. 'a to 'z
set viminfo='1000,f1

"}}}
" encoding {{{
"------------------------------------------////

scriptencoding utf-8
set encoding=utf-8
"set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\

"}}}
" Visual {{{
"------------------------------------------------------
syntax on 			" enable color syntax
set number			" show line numbers on left side
set relativenumber		" show relative line numbers
"set modeline
set ls=2			" display jilename statusbar
set ignorecase 			" ignore case when searching
set hlsearch 			" highlight searches
set incsearch			" increamental search, find as you type word
set title			" show title in console title bar
"set cursorcolumn		" show column highlight
"set cursorline			" show line highlight
"set mouse-=a			" disable mouse automatically entering visual mode
"set mouse=a			" enable mouse support and activate visual mode with dragging


" toggle absolute and relative numbers
" http://www.reddit.com/r/vim/comments/vowr6/numbersvim_better_line_numbers_for_vim/
" auto change numbers on mode switch
silent! autocmd InsertEnter * :set norelativenumber
silent! autocmd InsertLeave * :set relativenumber
nnoremap <F2> :se <c-r>=&rnu?"":"r"<CR>nu<CR>
" toggle absolute,relative, and no numbers
"map <Leader>nn :set <c-r>={'00':'','01':'r','10':'nor'}[&rnu.&nu]<CR>nu<CR>

"}}}
" Themes {{{
"------------------------------------------------------
"set background=dark	" set background dark color
set background=light	" set background light color
colorscheme torte
"}}}
" Indent Guides {{{
" }}}
" Visual Mode */# from Scrooloose {{{

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" }}}
" Word Processor Mode {{{
"------------------------------------------------------
" http://jasonheppler.org/2012/12/05/word-processor-mode-in-vim/
" http://robots.thoughtbot.com/wrap-existing-text-at-80-characters-in-vim
func! WordProcessorMode()
    setlocal formatoptions=t1
    setlocal textwidth=80
    map j gj
    map k gk
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfu
com! WP call WordProcessorMode()

" http://robots.thoughtbot.com/wrap-existing-text-at-80-characters-in-vim
" http://www.drbunsen.org/writing-in-vim/

"}}}
"{{{ Word Wrapping
"------------------------------------------------------
" better word wrapping: breaks at spaces or hyphens
set formatoptions=l
set lbr

"}}}
" ranger file browser {{{
"------------------------------------------------------
" http://www.everythingcli.org/use-ranger-as-a-file-explorer-in-vim/
function! RangerExplorer()
    exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
    if filereadable('/tmp/vim_ranger_current_file')
        exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
        call system('rm /tmp/vim_ranger_current_file')
    endif
    redraw!
endfun
map <Leader>r :call RangerExplorer()<CR>

"}}}
