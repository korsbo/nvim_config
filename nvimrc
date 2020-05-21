let g:mapleader = "\<Space>"
let g:python3_host_prog = "/home/niklas/software/miniconda3/bin/python"

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible              " be iMproved, required
" filetype off                  " required

call plug#begin('~/.local/share/nvim/plugged')
"=============================================================================="
"================================  Navigation  ================================"
"=============================================================================="

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    nmap <leader>n :NERDTreeToggle<CR>
    let NERDTreeMapOpenInTab='\t'
    let NERDTreeQuitOnOpen = 1
    let NERDTreeAutoDeleteBuffer = 1
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1
    let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$']
    let NERDTreeMouseMode = 2 
    let NERDTreeNaturalSort = 1 
    let NERDTreeShowBookmarks = 1 
    let NERDTreeShowHidden = 1 
    autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set rtp+=~/.fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
    source ~/.config/nvim/fzf_config.vim
" }}}
Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nmap <leader>a :Ack<space> 

"=============================================================================="
"=================================  Editing  =================================="
"=============================================================================="

Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" {{{
  nnoremap <leader>c :Commentary 
  autocmd FileType julia setlocal commentstring=#\ %s
" }}}
Plug 'godlygeek/tabular'
Plug 'FooSoft/vim-argwrap'
autocmd FileType julia let b:argwrap_tail_comma=1
nnoremap <silent> <leader>e :ArgWrap<CR>

" Expand the ability to use text-object operations.
Plug 'jeanCarloMachado/vim-toop'

Plug 'kana/vim-textobj-user'
"{{{
  call textobj#user#plugin(
\   'runblock',
\   {
\       'block': {
\           'pattern' : ['#<<', '#>>'], 
\           'select-a': 'ao',
\           'select-i': 'io',
\       }
\   })
"}}}
"=============================================================================="
"================================  Appearance  ================================"
"=============================================================================="
Plug 'nathanaelkane/vim-indent-guides'
" Status bar 
Plug 'vim-airline/vim-airline'
Plug 'machakann/vim-highlightedyank'
Plug 'korsbo/srcery-vim'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'lifepillar/vim-solarized8'

""=============================================================================="
""=======================  Asynchronous code completion  ======================="
""=============================================================================="
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'deoplete-plugins/deoplete-zsh'
  " Plug 'deoplete-plugins/deoplete-jedi'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" {{{
    let g:deoplete#enable_at_startup = 1
    " function! Multiple_cursors_before()
    "     call deoplete#custom#buffer_option('auto_complete', v:false)
    " endfunction
    " function! Multiple_cursors_after()
    "     call deoplete#custom#buffer_option('auto_complete', v:true)
    " endfunction
    autocmd FileType tex call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})
" }}}

" Use release branch
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }


"=============================================================================="
"=============================  Terminal support  ============================="
"=============================================================================="
"Plug 'kassio/neoterm' 
"" {{{
"    " - *c*lear, *c*trl-c, workspace *c*ommand
"    nnoremap <silent> <leader>cl :call neoterm#clear()<cr>
"    nnoremap <silent> <leader>cc :call neoterm#kill()<cr>
"    nnoremap <silent> <leader>cw :call neoterm#do("workspace()")<cr>
"    " - show *j*ulia @doc, show(info)
"    " nnoremap <silent> <localleader>jd :Texec ("@doc " . expand("<cword>"))<cr>
"    " nnoremap <silent> <localleader>je :call neoterm#do("@edit " . expand("<cword>"))<cr>
"    " nnoremap <silent> <localleader>ji :call neoterm#do(expand("<cword>"))<cr>
"    " - send *a*ll, i.e. file
"    nnoremap <silent> <leader>aa :w<cr>:T includet("%")<cr>
"    nnoremap <silent> <leader>ae :w<cr>:TREPLSendFile<cr>
"    " - send *p*aragraph (cursor location changes)
"    nnoremap <silent> <leader>pp mavap:TREPLSendLine<cr><esc>`a
"    nnoremap <silent> <leader>pd vap:TREPLSendLine<cr><esc>}
"    " - send *s*election (cursor location changes)
"    vnoremap <silent> <leader>ss :TREPLSendSelection<cr>
"    vnoremap <silent> <leader>l :TREPLSendSelection<cr>
"    vnoremap <silent> <leader>sd :TREPLSendSelection<cr>j
"    vnoremap <silent> <leader>d :TREPLSendSelection<cr>j
"    " - send *l*ine, optionally go *d*own
"    nnoremap <silent> <leader>l :TREPLSendLine<cr>
"    nnoremap <silent> <leader>d :TREPLSendLine<cr>j
"    "
"    "
"    tnoremap <Esc> <c-\><c-n>
"    tnoremap <C-Esc> <Esc>
"    tnoremap <C-k> <c-\><c-n><c-w>k
"    tnoremap <C-t> <c-\><c-n><c-w>t
"    tnoremap <C-h> <c-\><c-n><c-w>h
"    tnoremap <C-l> <c-\><c-n><c-w>l
"    au FileType fzf silent! tunmap <Esc>
"    " tnoremap <C-k> <C-w><Up>
"    " tnoremap <C-l> <C-w><Right>
"    " tnoremap <C-t> <C-w><Down>
"    " tnoremap <C-h> <C-w><Left>
"    "
"    autocmd TermOpen <Buffer> setlocal scrolloff=0
"    let g:neoterm_default_mod="belowright"
"    let g:neoterm_size=25
"" }}}

Plug 'benmills/vimux'
Plug 'julienr/vimux-pyutils'
" {{{
    map <leader>vp :VimuxPromptCommand<CR>
    map <leader>vr :VimuxRunCommand<CR>
    map <leader>vi :VimuxInspectRunner<CR>
" }}}
Plug 'epeli/slimux'
" {{{
        " nnoremap <silent> <leader>aa :w<cr>:SlimuxShellRun includet(\"\%\")<cr>
    " nnoremap <silent> <leader>ae :w<cr>:SlimuxREPLSendBuffer<cr>
    " - send *p*aragraph (cursor location changes)
    " nnoremap <silent> <leader>pp mavap:SlimuxREPLSendSelection<cr><esc>`a
        " au FileType julia <buffer> nnoremap <silent> <leader>pp ma:call julia_blocks#moveblock_p()<cr>mb:call julia_blocks#moveblock_N()<cr>v`b<esc>:SlimuxREPLSendSelection<cr><esc>`a
        " nnoremap <silent> <leader>pp ma:call julia_blocks#moveblock_p()<cr>mb:call julia_blocks#moveblock_N()<cr>V`b:SlimuxREPLSendSelection<cr><esc>`a
    " nnoremap <silent> <leader>pd vap:SlimuxREPLSendSelection<cr><esc>}
    " - send *s*election (cursor location changes)
    " vnoremap <silent> <leader>ss :SlimuxREPLSendSelection<cr>
    " vnoremap <silent> <leader>l ma:SlimuxREPLSendSelection<cr>`a
    " vnoremap <silent> <leader>sd :SlimuxREPLSendSelection<cr>j
    " vnoremap <silent> <leader>d :SlimuxREPLSendSelection<cr>j
    " - send *l*ine, optionally go *d*own
    nnoremap <silent> <leader>l mj:SlimuxREPLSendLine<cr>`j
    " nnoremap <silent> <leader>d :SlimuxREPLSendLine<cr>j
    function! SendAndReturn(str) abort
        execute "normal! mj"
        call SlimuxSendCode(a:str)
        execute "normal! `j"
    endfunction
    " autocmd FileType julia call toop#mapFunction('SlimuxSendCode', '<leader>s')
    autocmd FileType julia call toop#mapFunction('SendAndReturn', '<leader>s')
    autocmd FileType markdown call toop#mapFunction('SendAndReturn', '<leader>s')
    let g:slimux_select_from_current_window=1
" }}}

Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-t> :TmuxNavigateDown<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-/> :TmuxNavigatePrevious<cr>

"=============================================================================="
"=================================  Snippets  ================================="
"=============================================================================="

Plug 'SirVer/ultisnips'
    " make YCM compatible with UltiSnips (using supertab)
    " let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    " let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    " let g:SuperTabDefaultCompletionType = '<C-n>'

    " better key bindings for UltiSnipsExpandTrigger
    " let g:UltiSnipsExpandTrigger = "<tab>"
    " let g:UltiSnipsJumpForwardTrigger = "<tab>"
    " let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

    let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']


Plug 'honza/vim-snippets'

"=============================================================================="
"===================================  Git  ===================================="
"=============================================================================="
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

"=============================================================================="
"=============================  Language support  ============================="
"=============================================================================="
Plug 'JuliaLang/julia-vim'
" {{{
    let g:default_julia_version = '1.2'
    au VimEnter,BufRead,BufNewFile *.jl set filetype=julia
    autocmd FileType julia setlocal commentstring=#\ %s
    runtime macros/matchit.vim
" }}}
"
Plug 'kdheepak/JuliaFormatter.vim'
" {{{
    " normal mode mapping
    " autocmd FileType julia nnoremap <leader>ff :<C-u>call JuliaFormatter#Format(0)<CR>
    " visual mode mapping
    autocmd FileType julia vnoremap <leader>ff :<C-u>call JuliaFormatter#Format(1)<CR>
    autocmd FileType julia nnoremap <leader>fip mjvip:<C-u>call JuliaFormatter#Format(1)<CR><esc>`j
    autocmd FileType julia nnoremap <leader>fis mjvis:<C-u>call JuliaFormatter#Format(1)<CR><esc>`j
    autocmd FileType julia nnoremap <leader>ff mjvaj:<C-u>call JuliaFormatter#Format(1)<CR><esc>`j

    function! JuliaFormatObject(str) abort
        if !get(g:, 'JuliaFormatter_loaded')
            call JuliaFormatter#Launch()
        end
        let l:str = split(a:str, '\n')
        return JuliaFormatter#Send('format', {'text': l:str})
    endfunction
    autocmd FileType julia call toop#mapFunction('JuliaFormatObject', '<leader>a')
    " autocmd FileType julia call toop#mapFunction('JuliaFormatter#Format(1)', '<leader>f')
" }}}

" Plug 'ivanov/vim-ipython'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" {{{
    let g:pymode_virtualenv=1
" }}}

" py << EOF
" import os
" import sys
" if 'VIRTUAL_ENV' in os.environ:
"   project_base_dir = os.environ['VIRTUAL_ENV']
"   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"   execfile(activate_this, dict(__file__=activate_this))
" EOF
"

" Plug 'w0rp/ale'

Plug 'cmci/ImageJMacro_Highlighter'

Plug 'lervag/vimtex'
" {{{
    let g:vimtex_compiler_method = 'latexmk'
    let g:vimtex_compiler_progname = 'nvr'
    let g:vimtex_quickfix_mode=0
    set conceallevel=1
    let g:tex_conceal='abdmg'

    let g:vimtex_view_general_viewer = 'zathura'
    let g:vimtex_view_method= 'zathura'
    "let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
    let g:vimtex_view_general_options = '-s'
    "let g:vimtex_view_general_options_latexmk = '--unique'

    autocmd FileType tex map <buffer> jse <plug>(vimtex-env-toggle-star)
    autocmd FileType tex map <buffer> jsd <plug>(vimtex-delim-toggle-modifier)
    autocmd FileType tex map <buffer> jsD <plug>(vimtex-delim-toggle-modifier-reverse)
    autocmd FileType tex map <buffer> jsc <plug>(vimtex-cmd-toggle-star)

    autocmd FileType tex silent! unmap <buffer> <leader>l 

    autocmd FileType tex nmap <buffer> <localleader>ll :w<CR><Plug>(vimtex-compile)
    autocmd FileType tex nnoremap <buffer> <localleader>lt :call vimtex#fzf#run()<cr>
    autocmd FileType tex setlocal textwidth=80

    autocmd FileType tex setlocal spell
    
    " Make C-l fix last spelling mistake while in insert mode.
    autocmd FileType tex inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
    autocmd FileType tex setlocal whichwrap=b,s,h,l,<,>

    autocmd FileType tex inoremap <buffer> <C-e> <plug>(vimtex-delim-close)


    let g:Tex_IgnoredWarnings = 
        \"Underfull\n".
        \"Overfull\n".
        \"specifier changed to\n".
        \"You have requested\n".
        \"Missing number, treated as zero.\n".
        \"There were undefined references\n".
        \"Citation %.%# undefined\n".
        \"Font Shape"
    let g:Tex_IgnoreLevel = 8
    let g:Tex_GotoError = 0


" }}}
Plug 'matze/vim-tex-fold'

Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1


Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" Plug 'plasticboy/vim-markdown'
au VimEnter,BufRead,BufNewFile *.jmd set filetype=juliamarkdown

Plug 'plasticboy/vim-markdown'

"=============================================================================="
"===================================  Misc  ==================================="
"=============================================================================="

Plug 'thanthese/Tortoise-Typing'
Plug 'junegunn/goyo.vim'
function! ProseMode()
  call goyo#execute(0, [])
  setlocal spell noci nosi noai nolist noshowmode noshowcmd
  setlocal spelllang=en_gb
  setlocal complete+=s

  "set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  setlocal formatprg=par
  setlocal linebreak 
  setlocal autoread
  " colors solarized
endfunction

command! ProseMode call ProseMode()
nmap <leader>w :ProseMode<CR>


"
call plug#end()            " required
"=============================================================================="
"==============================  End of plugins  =============================="
"=============================================================================="

" filetype plugin indent on    " required
" filetype plugin on

let g:deoplete#enable_at_startup = 1
call deoplete#enable()
call deoplete#custom#source('_',
    \ 'disabled_syntaxes', ['Comment', 'String'])
call deoplete#custom#option('sources', {
    \ 'julia': ['LanguageClient'],
    \})
call deoplete#custom#var('omni', 'input_patterns', {
            \ 'tex': g:vimtex#re#deoplete
            \})
call deoplete#custom#source('ultisnips', 'rank', 1000)

"=====[ Enable Nmap command for documented mappings ]================
runtime bundle/plugin/documap.vim
runtime macros/matchit.vim

" {{{  LanguageClient
    " set updatetime=300
    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_serverCommands = {
        \   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
        \       using LanguageServer;
        \       using Pkg;
        \       "Project.toml" in readdir() && Pkg.activate(".");
        \       import StaticLint;
        \       import SymbolServer;
        \       env_path = dirname(Pkg.Types.Context().env.project_file);
        \       debug = true; 
        \       
        \       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
        \       server.runlinter = true;
        \       run(server)
        \   '],
        \   'python': ['pyls',]
        \ }

    nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" }}}

"=============================================================================="
"================================  Appearance  ================================"
"=============================================================================="

" set highlighting when searching
set hls

" syntax enable " Turn on syntax highlighting  
set termguicolors
" colorscheme monokai
" colorscheme srcery
set background=light
colorscheme solarized8

" colorscheme vorange " for some reason this one will not switch on without first
" changing to another colorscheme
set number
set relativenumber
set hidden " Leave hidden buffers open  
set history=100 
set colorcolumn=92
set cursorline

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'julia']

silent! command DoMatchParen

" Mute the background color of unfocused window panes.
hi ActiveWindow ctermbg=16 | hi InactiveWindow ctermbg=236
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

if has('nvim')
    set inccommand=split
end


autocmd FileType julia setlocal commentstring=#\ %s

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
"exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
"set list

au BufRead,BufNewFile *.gnu set filetype=gnuplot

"=============================================================================="
"================================  Navigation  ================================"
"=============================================================================="

set mouse=a

" make Y yank from cursor to end of line
nnoremap Y y$

" nnoremap <C-/> :Commentary

" bring up command without pressing shift
" map ; :
"Nmap s [:] :
nmap s :
"noremap ;; ;

" Switch between tabs
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt

" Close a buffer without closing the window.
map <leader>q :b#<cr>:bd#<cr>

"map <Right> g<Right>
"map <Left> g<Left>
map <Up> g<Up>
map <Down> g<Down>

" I'm too much of a config junkie to have to type this out.
command! R e ~/.nvimrc

"=============================================================================="
"=================================  Editing  =================================="
"=============================================================================="
" Save me from my frequent but never ambiguous typos.
iabbrev teh the
iabbrev Teh The
iabbrev lenght length
iabbrev Lenght Length

"I'm sick of typing :%s/.../.../g
"Nmap S  [Shortcut for :s///g]  :%s//g<LEFT><LEFT>
nmap S   :%s//g<LEFT><LEFT>
vmap S                         :s//g<LEFT><LEFT>

"Nmap <expr> M  [Shortcut for :s/<last match>//g]  ':%s/' . @/ . '//g<LEFT><LEFT>'
nmap <expr> M ':%s/' . @/ . '//g<LEFT><LEFT>'
vmap <expr> M ':s/' . @/ . '//g<LEFT><LEFT>'

vnoremap <leader>S "hy:%s/<C-r>h//g<left><left><left>


" Let Y in visual append clipboard rather than replace.
vnoremap <silent> Y <ESC>:silent let @y = @"<CR>gv"Yy:silent let @" = @y<CR>

" Create an in-line comment heading 
nnoremap <leader>h :center 80<cr>3hv0r#2A<space><esc>40A#<esc>d80<bar>YppVr#kk.

" Surround all =, +=, .*=, etc with a single space, unless they are in a
" # comment.
" nnoremap <leader>= mj:g/^[^#]/s/\(\w\)\s*\(\W*=\)\s*/\1 \2 /g<cr>:nohls<cr>`j
nnoremap <leader>= mj:g/^[^#]/s/\s*\([^a-zA-Z0-9)}\]]*=\)\s*/ \1 /g<cr>:nohls<cr>`j


" ================ Settings  ==================
set encoding=UTF-8

set wildmenu
set wildmode=list:longest,full
set incsearch
set ignorecase
set smartcase
set infercase

set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set smarttab

set scrolloff=10
set undolevels=5000
set clipboard=unnamed,unnamedplus
set lazyredraw
set hidden
set noswapfile
set virtualedit=onemore
set showcmd

command! W w
command! Q q

set shell=/usr/bin/zsh

" ================ Julia ==================
" LongDef, a not-really-functional prototype for replacing short form
" functions with long form ones.
" function! LongDef()
"     let line = getline(".")
"     let longform = substitute(line, '\(.*\)(\(.*\)).*=\s*\(.*\)', 'function \1(\2)\n    \3\rend\n', "")
"     call append(".", longform)
" endfun

" ================ LATEX ==================
" let g:tex_flavor = "latex"
" let g:Tex_DefaultTargetFormat="pdf"
" set grepprg=grep\ -nH\ $*


function! SentenceFormatting(start, end)
    silent execute a:start.','.a:end.'s/[.!?]\zs /\r/g'
endfunction

function! SentenceBreakOut()
    execute "normal! l("
    if col(".") != 1
        execute "normal! i\<cr>"
    end
    execute "normal! dis"
    let s = @"
    let s = substitute(s, "\n", " ", "g")
    let @" = s . "\n"
    execute "normal! P"
    execute "normal! =j"
endfunction
autocmd FileType tex nnoremap <buffer> <leader>s :call SentenceBreakOut()<cr>
" autocmd FileType tex nnoremap <buffer> <leader>s cis<cr><cr><cr><up><up><esc>pvis:s/\n/ /g<cr>:nohls<cr>


function! WordProcessorMode()
  setlocal noexpandtab 
  setlocal colorcolumn=0
  "map j gj
  "map k gk
  setlocal spell spelllang=en_gb
  "set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
  set autoread
endfunction 
com! WP call WordProcessorMode()

" Reformat lines (getting the spacing correct) {{{
fun! TeX_fmt()
    if (getline(".") != "")
    let save_cursor = getpos(".")
        let op_wrapscan = &wrapscan
        set nowrapscan
        let par_begin = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\[\|\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
        let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\[\|\\]\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
    try
      exe '?'.par_begin.'?+'
    catch /E384/
      1
    endtry
        norm V
    try
      exe '/'.par_end.'/-'
    catch /E385/
      $
    endtry
    norm gq
        let &wrapscan = op_wrapscan
    call setpos('.', save_cursor) 
    endif
endfun
" }}}

" ================ Workman Keylayout ==================
inoremap <S-Space> _
function! Workman_minimal()
  " (t)ill -> (j)ump
  noremap j t
  noremap J T
  noremap t j
  noremap T J

  "onoremap j t
  "onoremap J T
  "onoremap t j
  "onoremap T J

  nnoremap t gj
  vnoremap t gj
  nnoremap k gk
  vnoremap k gk

  noremap <C-f> <C-d>
endfunction

function! Unmap_workman_minimal()
  silent! nunmap j
  silent! nunmap J
  silent! nunmap t
  silent! nunmap T
endfunction

function! Workman_home_row()
  "(O)pen line -> (L)ine
  nnoremap l o
  nnoremap o l
  nnoremap L O
  nnoremap O L
  "Search (N)ext -> (J)ump
  nnoremap j n
  nnoremap n j
  nnoremap J N
  nnoremap N J
  "(E)nd of word -> brea(K) of word
  nnoremap k e
  nnoremap e k
  nnoremap K E
  nnoremap E <nop>
  nnoremap h y
  onoremap h y
  "(Y)ank -> (H)aul
  nnoremap y h
  nnoremap H Y
  nnoremap Y H
endfunction

function! Unmap_workman_home_row()
  "Unmaps Workman keys
  silent! nunmap h
  silent! ounmap h
  silent! nunmap j
  silent! nunmap k
  silent! nunmap l
  silent! nunmap y
  silent! nunmap n
  silent! nunmap e
  silent! nunmap o
  silent! nunmap H
  silent! nunmap J
  silent! nunmap K
  silent! nunmap L
  silent! nunmap Y
  silent! nunmap N
  silent! nunmap E
  silent! nunmap O
endfunction

call Workman_minimal()

if has('gui_running')
  "set guioptions-=T  " no toolbar
  "set lines=60 columns=108 linespace=0
  if has('gui_win32')
    set guifont=DejaVu_Sans_Mono:h10:cANSI
  else
    set guifont=DejaVu\ Sans\ Mono\ 9
  endif
endif




"======[ Add a Y command for incremental yank in Visual mode ]==============




"=============== source vimrc if saved =============
augroup VimReload
  autocmd!
  autocmd BufWritePost ~/.nvimrc source ~/.nvimrc
augroup END



"=============== enable local vimrc =============
set exrc
set secure
