" vim:fdm=marker

" startup settings {{{
let s:gui=has('gui_macvim')
" }}}

" general settings {{{
"
set laststatus=2                                            " always show status line
set scrolloff=3                                             " keep 3 lines when scrolling
set showcmd                                                 " display incomplete commands
set term=xterm-256color
set mouse=a                                                 " use a mouse
set ttyfast
set cursorline                                              " highlight the current line
set novisualbell                                            " turn off visual bell
set nobackup                                                " do not keep a backup file
set noswapfile
set nowritebackup
set relativenumber
set display+=lastline
set ignorecase                                              " ignore case when searching
set title                                                   " show title in console title bar
set clipboard+=unnamed                                      " share the yank register
set nostartofline                                           " don't jump to first character
set whichwrap+=h,l,<,>,[,]                                  " move freely between files
set showbreak=↪                                             " better line wraps
set shortmess=aoOtI                                         " abbreviate messages
set diffopt+=vertical                                       " default vertical diff split
set lazyredraw
set noautoindent
set nosmartindent
set switchbuf=usetab
set et|retab
set showmatch                                               " show matching braces
set matchtime=5
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set backspace=indent,eol,start                              " set backspace
set tabstop=4 shiftwidth=4 expandtab                        " numbers of spaces to (auto)indent
filetype off
filetype plugin on
filetype plugin indent on
filetype indent on
syntax on                                                   " syntax highlighing
set iskeyword+=_,$,@,%,#,-                                  " do not split words with these
set wildmenu
set wildmode=longest,list,full
let &t_SI="\<Esc>]50;CursorShape=1\x7"                      " Vertical bar in insert mode
let &t_EI="\<Esc>]50;CursorShape=0\x7"                      " Block in normal mode
" }}}

" plugins related {{{
"
" vundle {{{
let s:manager=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let s:manager=0
endif
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
let g:vundle_default_git_proto='git'
Plugin 'VundleVim/Vundle.vim.git'
" }}}
" setting {{{
Plugin 'bling/vim-airline'
let g:airline_powerline_fonts=1
set noshowmode
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='hybrid'
let g:airline#extensions#tabline#enabled=1
"
Plugin 'kristijanhusak/vim-hybrid-material'
set background=dark
colorscheme hybrid_material
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
Plugin 'romainl/Apprentice'
" }}}
" motion {{{
Plugin 'Lokaltog/vim-easymotion'
"
Plugin 'justinmk/vim-gtfo'
let g:gtfo#terminals={ 'mac' : 'iterm' }
"
Plugin 'haya14busa/incsearch.vim'
map /  <plug>(incsearch-forward)
map ?  <plug>(incsearch-backward)
map g/ <plug>(incsearch-stay)
"
Plugin 'terryma/vim-expand-region'
vnoremap v <plug>(expand_region_expand)
vnoremap <c-v> <plug>(expand_region_shrink)
" }}}
" editing {{{
Plugin 'godlygeek/tabular'
Plugin 'abbiekre/MatlabFilesEdition'
Plugin 'zmughal/vim-matlab-fold'
Plugin 'tpope/vim-surround'
Plugin 'chip/vim-fat-finger'
Plugin 'tpope/vim-eunuch'
Plugin 'osyo-manga/vim-brightest'
Plugin 'JuliaEditorSupport/julia-vim'
autocmd BufRead,BufNewFile *.jl set filetype=julia
"
Plugin 'kana/vim-operator-user'
Plugin 'haya14busa/vim-operator-flashy'
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
"
Plugin 'tpope/vim-commentary'
autocmd FileType matlab set commentstring=%\ %s
autocmd FileType r set commentstring=#\ %s
autocmd FileType dosini set commentstring=#\ %s
"
Plugin 'mechatroner/rainbow_csv'
Plugin 'chrisbra/csv.vim'
autocmd BufEnter *.csv setfiletype csv
"
Plugin 'junegunn/goyo.vim'
nnoremap <leader>f :Goyo<cr>
let g:goyo_linenr=1
"
Plugin 'junegunn/limelight.vim'
function! GoyoBefore()
    Limelight
endfunction
function! GoyoAfter()
    Limelight!
endfunction
let g:goyo_callbacks=[function('GoyoBefore'), function('GoyoAfter')]
"
Plugin 'luochen1990/rainbow'
let g:rainbow_active=1
let g:rainbow_conf={
            \ 'guifgs':['steelblue3','darkorange3',
            \ 'seagreen3','darkorchid3','firebrick'],
            \ 'ctermfgs':['lightblue','lightgreen',
            \ 'yellow','red','magenta']
            \ }
"
Plugin 'reedes/vim-wordy'
noremap <silent> <f8> :<c-u>NextWordy<cr>
xnoremap <silent> <f8> :<c-u>NextWordy<cr>
inoremap <silent> <f8> <c-o>:NextWordy<cr>
" }}}
"
Plugin 'jiangmiao/auto-pairs'
autocmd Filetype tex
            \ let g:AutoPairs={'(':')','[':']','{':'}','$':'$',
            \ "'":"'",'"':'"'}
autocmd Filetype markdown
            \ let g:AutoPairs={'(':')','[':']','{':'}','$':'$','$$':'$$',
            \ "'":"'",'"':'"'}
" }}}
" latex {{{
Plugin 'jcf/vim-latex'
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf,aux'
let g:Tex_CompileRule_pdf=
            \ 'pdflatex -synctex=1 -interaction=nonstopmode -shell-escape $*'
function CompileXeTex()
    let DefaultCompileRule=g:Tex_CompileRule_pdf
    let g:Tex_CompileRule_pdf=
                \ 'xelatex -synctex=1 -interaction=nonstopmode -shell-escape $*'
    call Tex_RunLaTeX()
    let g:Tex_CompileRule_pdf=DefaultCompileRule
endfunction
nnoremap <leader>lx :<c-u>call CompileXeTex()<cr>
let g:Tex_GotoError=0
let g:Tex_ViewRule_pdf='Skim'
let g:tex_comment_nospell=1
let g:tex_conceal="agdm"
autocmd BufNewFile,BufRead,BufEnter *.tex nnoremap <leader>lc :!latexmk -c %<cr><cr>
" }}}
" programming {{{
Plugin 'matze/vim-ini-fold'
Plugin 'Yggdroot/indentLine'
let g:indentLine_color_gui='#AF87AF'
let g:indentLine_color_term=178
"
Plugin 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='!'
let g:syntastic_style_error_symbol='✗'
let g:syntastic_style_warning_symbol='!'
let g:syntastic_full_redraws=1
let g:syntastic_auto_jump=2
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=0
let g:syntastic_tex_checkers=['chktex']
let g:syntastic_tex_chktex_args='-I'
let g:syntastic_quiet_messages={"regex":['ASCII','ellipsis']}
let g:syntastic_python_pylint_args='--disable=C0103,C0111,C0301'
" }}}
" vundle {{{
if s:manager==0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
" }}}
" }}}

" command related {{{
"
" automatically change directory
autocmd BufEnter * silent! lcd %:p:h
"
" disable auto commenting
autocmd BufEnter * set formatoptions -=cro
"
" resize splits when the window is resized
autocmd VimResized * :wincmd =
"
" automatic strip trailing white spaces
autocmd BufWritePre * :%s/\s\+$//e
"
" automatic remove zero-width spaces
autocmd BufWritePre * :%s/\%u200b//e
"
" show ruler for some filetypes
autocmd FileType python,matlab call SetRuler()
function SetRuler()
    highlight ColorColumn ctermbg=DarkGrey
    set colorcolumn=80
endfunction
"
" automatically wrap and indent
autocmd Filetype tex,matlab,python,sh
            \ nnoremap <leader>w gg=G''
"
" automatically chmod +x Shell, Perl and Python scripts
autocmd BufWritePost *.sh,*.pl,*.py,*.gmt silent !chmod +x %
"
" spelling
nnoremap <F6> :setlocal spell! spelllang=en<cr>
set spellfile=$DROPBOX/Sync/Usage/en.utf-8.add
nnoremap <silent><leader>es :e $HOME/Dropbox/Sync/Usage/en.utf-8.add<cr>
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=red term=underline cterm=underline gui=undercurl guisp=orange
syn match myExCapitalWords +\<\w*[A-Z]\K*\>\|'s+ contains=@NoSpell
function! IgnoreParenthesisSpell()                          " Ignore parenthesis
    syn match Parenthesis /\<\(.\)\>/ contains=@NoSpell transparent
    syn cluster Spell add=Parenthesis
endfunction
autocmd Filetype tex :call IgnoreParenthesisSpell()
"
" completion
set dictionary=/usr/share/dict/words
set complete-=k complete+=k
set completeopt=menu,menuone,preview
inoremap <tab> <c-r>=Tab_Complete()<cr>
function! Tab_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<c-n>"
  else
    return "\<tab>"
  endif
endfunction
"
" jump to last position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
            \ exe "normal! g`\"" | endif
"
" folding
autocmd Filetype tex,matlab normal zR
"
" bubbling lines
nmap <s-u> ddkP
nmap <s-d> ddp
vmap <s-u> xkP`[V`]
vmap <s-d> xp`[V`]
"
" markdown conversion
autocmd BufEnter,BufNewFile *.md set filetype=markdown
if executable('pandoc')
    autocmd Filetype markdown nnoremap <leader>rl :w<cr>
                \ :silent !pandoc -V geometry:margin=1in -s
                \ --metadata-file=$DROPBOX/Research/Documents/pandoc_latex.yml
                \ % -o %:r.tex<cr>
                \ :!pdflatex %:r.tex<cr> :!latexmk -c %:r.tex<cr>
                \ :redraw!<cr>
    autocmd Filetype markdown nnoremap <leader>rd :w<cr>
                \ :silent !pandoc -f markdown+smart -t docx
                \ --bibliography $DROPBOX/Research/Papers/Reference.bib
                \ --csl=$DROPBOX/Research/Documents/apalike.csl % -o %:r.docx<cr>
                \ :redraw!<cr>
endif
" }}}

" software related {{{
"
set shell=/bin/bash
let $PATH .=':~/Dropbox/Research/Scripts'
"
" quick run scripts
map <f5> :call CompileRunGcc()<cr>
function! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        !g++ % -o %<
        !time ./%<
    elseif &filetype == 'cpp'
        !g++ % -o %<
        !time ./%<
    elseif &filetype == 'java'
        !javac %
        !time java %<
    elseif &filetype == 'sh'
        !time bash %
    elseif &filetype == 'python'
        !time python %
    elseif &filetype == 'html'
        !open % &
    elseif &filetype == 'gmt'
        !bash %<cr>:redraw!<cr>
    elseif &filetype == 'markdown'
        !markdown.pl % > %:r.html &
        !open %:r.html &
    endif
endfunction
"
" python
if executable('yapf')
    autocmd Filetype python nnoremap <leader>y :0,$!yapf<cr>
endif
"
" octave
if executable('octave') && !executable('matlab')
    autocmd FileType matlab map <buffer> <f5> ggOpkg load all<esc>
                \ Gopause<esc>:w<cr>:!octave -qf %<cr>ddggdd:w<cr>
endif
"
" tikz
autocmd BufRead,BufNewFile *.tikz set filetype=tex
autocmd BufEnter *.tikz nnoremap <leader>r
            \ :w<cr>:silent !tikz2pdf.py -q %<cr>:redraw!<cr>
" }}}

" mapping related {{{
"
inoremap jk <esc>
cabbrev ew :wq                                              " make :ew quit
nnoremap <F2> :edit!<cr>
nnoremap j gj
nnoremap k gk
if &diff
    colorscheme apprentice
    set nonumber
    nnoremap j gj
    nnoremap k gk
endif
nnoremap ; :
vnoremap ; :
vmap > >gv                                                  " Preserve selection after indentation
vmap < <gv
vmap <tab> >gv                                              " Map tab to indent in visual mode
vmap <s-tab> <gv
nnoremap <tab> %
nnoremap <space><space> V
noremap H ^
noremap L $
vnoremap L g_                                               " Easy moving
nnoremap vv ^vg_
nnoremap ,w <c-w>
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
nnoremap <s-h> <c-w>h
nnoremap <s-j> <c-w>j
nnoremap <s-k> <c-w>k
nnoremap <s-l> <c-w>l
nnoremap <leader>v <c-w>v<c-w>l
nnoremap <leader>h <c-w>s<c-w>l
nnoremap ,, <c-^>
nnoremap bn :bn<cr>
nnoremap bp :bp<cr>
noremap ,c :bd<cr>
nnoremap <silent><leader>ev :e $MYVIMRC<cr>
nnoremap <leader>c :set list!<cr>
nnoremap <leader>l :set number!<cr>
nnoremap <leader>o :set paste!<cr>
nnoremap <leader>ws :%s![^ ]\zs \+! !g<cr>:nohlsearch<cr>
nnoremap <leader>bl :%!cat -s<cr>
" zoom / restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed=0
    else
        let t:zoom_winrestcmd=winrestcmd()
        resize
        vertical resize
        let t:zoomed=1
    endif
endfunction
command! ZoomToggle call ZoomToggle()
nnoremap <silent> <leader>z :ZoomToggle<cr>
" auto-save when leave insert mode
autocmd InsertLeave * if expand('%') != '' | update | endif
" }}}

" gui related {{{
"
if s:gui
    set guioptions=egmrt
    let s:font="monofur\\ for\\ Powerline"
    set transparency=5
    let s:fontsize=":h18"
    let s:guifont='set guifont='.s:font.s:fontsize
    exec s:guifont
    set lines=42
    set columns=80
endif
" }}}
