
" ---------------------------------------------------------------------------
" Global Configuration
" ---------------------------------------------------------------------------
"
set nocompatible               " be iMproved
filetype off                   " required!
set laststatus=2
set encoding=utf-8
set t_Co=256
set title
set history=10000
let g:Powerline_symbols = 'fancy'
syntax on

" Visible cursor
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"

" Indents
    set tabstop=4 " Set the default tabstop
    set softtabstop=4
    set shiftwidth=4 " Set the default shift width for indents
    set shiftround " Use multiples of shiftwidth when indenting
    set expandtab " Make tabs into spaces (set by tabstop)
    set smarttab " Smarter tab levels
    set autoindent " auto indent
    set copyindent " and preserve on next line
    set pastetoggle=<F2> " toggle indents when pasting in vim! " Alternatively: <C-r>+
    set list " show invisible characters enumerated below
    set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Wrapping
    set nowrap " do not wrap lines
    set sidescroll=15 " ?
    set backspace=indent,eol,start " backspace over everything
    set linebreak " Do not wrap words. Caution! May be confusing!

" Folding
    set foldlevel=0
    set foldnestmax=15
    set foldmethod=manual
" Saves manual folds
    au BufWinLeave ?* mkview 1
    au BufWinEnter ?* silent loadview 1

" Search
    set showmatch " show matching character
    set ignorecase " for searching
    set smartcase " but only if lower case entered
    set hlsearch " show what is being searched
    set incsearch " real time incremental search

" Various sizing settings
    set hidden " hide buffers instead of closing them...keep undo, changes etc
    set history=1000
    set undolevels=1000 " a proper stack
    set nobackup " do not create bak files
    set noswapfile " no more ridiculous recovery

" Moving around
    set virtualedit=block " move past end of line
    " Tell cursor to not move when joining lines (using z mark)
    nnoremap J mzJ`z
    " Always center after search/end of paragraph jump
    nnoremap n nzz
    nnoremap } }zz
    " Swap next row/next line commmands
    nnoremap j gj
    nnoremap k gk
    nnoremap gj j
    nnoremap gk k

" Files
    set wildmode=longest,list " better filename autocomplete

augroup vimrcEx
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" ---------------------------------------------------------------------------
" Keyboard, Leader key, etc.
" ---------------------------------------------------------------------------
"
    set shortmess=atI

" Leader Key
    let mapleader = ","
    let g:mapleader = ","

    map <Leader>vp :VimuxPromptCommand<CR>
    map <Leader>vq :VimuxCloseRunner<CR>
    map <Leader>vi :VimuxInspectRunner<CR>
    map <Leader>vs :VimuxInterruptRunner<CR>
" Run the current file with rspec
    map <Leader>vb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
" rerun
    map <Leader>vl :VimuxRunLastCommand<CR>

    map <Leader>vyc :python run_tmux_python_chunk()<CR>
    map <Leader>vyb :python run_tmux_python_cell(False)<CR>
    map <Leader>vyg :python run_tmux_python_cell(True)<CR>

" make external keypad work in terminal vim OSX!
    map <Esc>Oq 1
    map <Esc>Or 2
    map <Esc>Os 3
    map <Esc>Ot 4
    map <Esc>Ou 5
    map <Esc>Ov 6
    map <Esc>Ow 7
    map <Esc>Ox 8
    map <Esc>Oy 9
    map <Esc>Op 0
    map <Esc>On .
    map <Esc>OQ /
    map <Esc>OR *
    map <kPlus> +
    map <Esc>OS -
    map <Esc>OM <CR>
    map! <Esc>Oq 1
    map! <Esc>Or 2
    map! <Esc>Os 3
    map! <Esc>Ot 4
    map! <Esc>Ou 5
    map! <Esc>Ov 6
    map! <Esc>Ow 7
    map! <Esc>Ox 8
    map! <Esc>Oy 9
    map! <Esc>Op 0
    map! <Esc>On .
    map! <Esc>OQ /
    map! <Esc>OR *
    map! <kPlus> +
    map! <Esc>OS -
    map! <Esc>OM <CR>

" Date insert
    :nnoremap <F4> "=strftime("%Y.%m.%d-%R")<CR>P
    :inoremap <F4> <C-R>=strftime("%Y.%m.%d-%R")<CR>

" Folding
    nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
    vnoremap <Space> zf

function! LoadVimPluginScript ()
    try
        call plug#begin('~/.vim/plugged')
        Plug 'altercation/vim-colors-solarized'
        Plug 'bronson/vim-trailing-whitespace'
        Plug 'Shougo/vimproc.vim'
        " Everything explorer simply try:
        " :Unite Unite file etc
        Plug 'Shougo/unite.vim'
        Plug 'Shougo/neomru.vim'
        " File Explorer
        " :VimFiler
        Plug 'Shougo/neocomplcache.vim'
        Plug 'Shougo/vimfiler.vim'
        " A shell entirely in vim
        " :VimShell
        Plug 'Shougo/vimshell.vim'
        " The silver searcher
        " :Ag [options] {pattern} [{directory}]
        Plug 'rking/ag.vim'
        " Display git change status in gutter
        " hidden by other plugin :(
        Plug 'airblade/vim-gitgutter'
        " Git integration
        " not working at this point
        Plug 'tpope/vim-fugitive'
        " Fancy status bar
        " 
        "Plug 'vim-airline/vim-airline'
        "Plug 'vim-airline/vim-airline-themes'
        Plug 'itchyny/lightline.vim'
        " Vim and Tmux
        " Alt+arrow keys etc
        Plug 'christoomey/vim-tmux-navigator'
        " Fuzzy search/open
        " FZF FZF ~ FZF --no-sort -m /tmp FZF! <Ctrl>-t <Ctrl>-x <Ctrl>-v
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
        Plug 'junegunn/fzf.vim'
        " Gray out what is not currently being edited
        " :Limelight
        Plug 'junegunn/limelight.vim'
        " Distraction free mode
        " :Goyo :Goyo!
        Plug 'junegunn/goyo.vim'
        " Surround with characters
        " cs"' ds" ysiw] cs]{
        Plug 'tpope/vim-surround'
        " Align code, json, etc.
        " vip<Enter>= or gaip= (align around '=')
        Plug 'junegunn/vim-easy-align'
        " Markup preview
        " :Xmark> :Xmark< :Xmark+ :Xmark- :Xmark!
        Plug 'junegunn/vim-xmark'
        " Tags
        Plug 'xolox/vim-misc'
        Plug 'xolox/vim-easytags'
        Plug 'majutsushi/tagbar'
        " Open in browser
        Plug 'tyru/open-browser.vim'
        Plug 'kannokanno/previm'
        " Neovim TMUX bindinds
        "Plug 'hkupty/nvimux'
        "
        call plug#end()
    catch
        " sigh
    endtry
endfunction

augroup loadVimPlugins
    autocmd!
    autocmd VimEnter * call LoadVimPluginScript()
augroup END

augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" ---------------------------------------------------------------------------
" Plugin interdependencies
" ---------------------------------------------------------------------------
"
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

filetype plugin indent on     " required!

" ---------------------------------------------------------------------------
" Everything below depends on external binaries
" ---------------------------------------------------------------------------

set rtp+=~/.fzf

" ---------------------------------------------------------------------------
" Everything below depends on plugins
" ---------------------------------------------------------------------------

" -- solarized personal conf
set background=dark
try
    colorscheme solarized
catch
endtry

" -- limelight visibility
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" -- easy align mapping
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" now try vip<Enter>= or gaip= (align around '=')

" -- 80th columns
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" -- the silver searcher

" Unite
"   depend on vimproc
"   ------------- VERY IMPORTANT ------------
"   you have to go to .vim/plugged/vimproc.vim and do a ./make
"   -----------------------------------------

let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
nmap <S-Tab> :<C-u>Unite -start-insert buffer file_rec/async<cr>
nnoremap <space><space>f :<C-u>Unite -start-insert buffer file_rec/async<cr>

" and

nmap b :UniteWithCursorWord grep:.<cr>
nnoremap <space>/ :Unite grep:.<cr>
nnoremap <space>y :Unite history/yank<cr>

" -- vimfiler
:let g:vimfiler_as_default_explorer = 1
nnoremap o :VimFiler<cr>

" -- Auto completion
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" -- Align
vnoremap <silent> <Enter> :EasyAlign<cr>

" -- TagBar
nmap <F2> :TagbarToggle<CR>

" ---------------------------------------------------------------------------
" Powerline
" ---------------------------------------------------------------------------
"
"    let g:airline_theme = "bubblegum"
"    let g:airline_powerline_fonts = 1
"    let g:airline_section_b = '%{strftime("%c")}'
"    let g:airline_section_y = 'BN: %{bufnr("%")}'
"    let g:airline#extensions#tabline#enabled = 1
    let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" ---------------------------------------------------------------------------
" TMUX Integration
" ---------------------------------------------------------------------------
"
if $TMUX != ''
  " integrate movement between tmux/vim panes/windows

  fun! TmuxMove(direction)
    " Check if we are currently focusing on a edge window.
    " To achieve that,  move to/from the requested window and
    " see if the window number changed
    let oldw = winnr()
    silent! exe 'wincmd ' . a:direction
    let neww = winnr()
    silent! exe oldw . 'wincmd'
    if oldw == neww
      " The focused window is at an edge, so ask tmux to switch panes
      if a:direction == 'j'
        call system("tmux select-pane -D")
      elseif a:direction == 'k'
        call system("tmux select-pane -U")
      elseif a:direction == 'h'
        call system("tmux select-pane -L")
      elseif a:direction == 'l'
        call system("tmux select-pane -R")
      endif
    else
      exe 'wincmd ' . a:direction
    end
  endfun

  function! TmuxSharedYank()
    " Send the contents of the 't' register to a temporary file, invoke
    " copy to tmux using load-buffer, and then to xclip
    " FIXME for some reason, the 'tmux load-buffer -' form will hang
    " when used with 'system()' which takes a second argument as stdin.
    let tmpfile = tempname()
    call writefile(split(@t, '\n'), tmpfile, 'b')
    call system('tmux load-buffer '.shellescape(tmpfile).';tmux show-buffer | xclip -i -selection clipboard')
    call delete(tmpfile)
  endfunction

  function! TmuxSharedPaste()
    " put tmux copy buffer into the t register, the mapping will handle
    " pasting into the buffer
    let @t = system('xclip -o -selection clipboard | tmux load-buffer -;tmux show-buffer')
  endfunction


  nnoremap <silent> <c-w>j :silent call TmuxMove('j')<cr>
  nnoremap <silent> <c-w>k :silent call TmuxMove('k')<cr>
  nnoremap <silent> <c-w>h :silent call TmuxMove('h')<cr>
  nnoremap <silent> <c-w>l :silent call TmuxMove('l')<cr>
  nnoremap <silent> <c-w><down> :silent call TmuxMove('j')<cr>
  nnoremap <silent> <c-w><up> :silent call TmuxMove('k')<cr>
  nnoremap <silent> <c-w><left> :silent call TmuxMove('h')<cr>
  nnoremap <silent> <c-w><right> :silent call TmuxMove('l')<cr>

  vnoremap <silent> <esc>y "ty:call TmuxSharedYank()<cr>
  vnoremap <silent> <esc>d "td:call TmuxSharedYank()<cr>
  nnoremap <silent> <esc>p :call TmuxSharedPaste()<cr>"tp
  vnoremap <silent> <esc>p d:call TmuxSharedPaste()<cr>h"tp  
  set clipboard= " Use this or vim will automatically put deleted text into x11 selection('*' register) which breaks the above map

  " Quickly send text to a pane using f6
  nnoremap <silent> <f6> :SlimuxREPLSendLine<cr>  
  inoremap <silent> <f6> <esc>:SlimuxREPLSendLine<cr>i " Doesn't break out of insert
  vnoremap <silent> <f6> :SlimuxREPLSendSelection<cr>

  " Quickly restart your debugger/console/webserver. Eg: if you are developing a node.js web app
  " in the 'serve.js' file you can quickly restart the server with this mapping:
  nnoremap <silent> <f5> :call SlimuxSendKeys('C-C " node serve.js" Enter')<cr>
  " pay attention to the space before 'node', this is actually required as send-keys will eat the first key

endif

" ---------------------------------------------------------------------------
" Filetype specific options
" ---------------------------------------------------------------------------
"
" Map markdown to recognized extension
    autocmd! BufRead,BufNewFile *.markdown set filetype=markdown
    autocmd! BufRead,BufNewFile *.md       set filetype=markdown

" For all text files
    autocmd FileType text
                \ highlight Excess ctermbg=DarkGrey guibg=Black |
                \ match Excess /\%78v.*/ |
                \ set nowrap

" Vimrc
    autocmd BufEnter vimrc setlocal nospell

" Vim Outliner
    autocmd BufEnter,BufNewFile *.otl
                \ setlocal nonumber |
                \ setlocal spell |
                \ highlight Excess ctermbg=DarkGrey guibg=Black |
                \ match Excess /\%78v.*/ |
                \ set nowrap |
                \ imap <S-CR> <CR><C-t>|
                \ imap <C-S-CR> <CR><C-d><BS>

" Text files
    autocmd BufEnter,BufNewFile *.txt
                \ setlocal spell |
                \ setlocal wrap |
                \ highlight Excess ctermbg=DarkGrey guibg=Black |
                \ match Excess /\%78v.*/ |
                \ set nowrap

" Python Files
    autocmd FileType python
        \ highlight Excess ctermbg=DarkGrey guibg=Black |
        \ match Excess /\%78v.*/ |
        \ set nowrap

" Markdown
    autocmd FileType mkd
        \ setlocal autoindent |
        \ setlocal colorcolumn=0 |
        \ setlocal linebreak |
        \ setlocal nonumber |
        \ setlocal shiftwidth=4 |
        \ setlocal spell |
        \ setlocal tabstop=4 |
        \ setlocal wrap

" Lisp
    "let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"~/Applications/ccl/dx86cl64 --load ~/.vim/plugged/slimv/slime/start-swank.lisp\""'

" fzf-rg
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" -- Local settings, if any
try
    source ~/.vimrc.local
catch
endtry
