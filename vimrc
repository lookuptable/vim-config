set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'SirVer/ultisnips'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/vim-go'
Plugin 'fatih/molokai'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'jnurmine/Zenburn'
Plugin 'Lokaltog/powerline', { 'rtp': 'powerline/bindings/vim/' }
Plugin 'majutsushi/tagbar'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-scripts/taglist.vim'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Enable file type based indent configuration and syntax highlighting.
" Note that when code is pasted via the terminal, vim by default does not detect
" that the code is pasted (as opposed to when using vim's paste mappings), which
" leads to incorrect indentation when indent mode is on.
" To work around this, use ":set paste" / ":set nopaste" to toggle paste mode.
" You can also use a plugin to:
" - enter insert mode with paste (https://github.com/tpope/vim-unimpaired)
" - auto-detect pasting (https://github.com/ConradIrwin/vim-bracketed-paste)
filetype plugin indent on
syntax on

" Enable line numbering
set nu

" Auto refresh unchanged file
set autoread

" I actually don't know why we need this :(
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

map <c-z> :NERDTreeTabsToggle<cr>
map <c-x> :TlistToggle<cr>

let g:EclimCompletionMethod = 'omnifunc'

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable code folding with spacebar
nnoremap <space> za

" Use `zz` to expand everythong
nnoremap zz zR

" python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Make python code look prettier
let python_highlight_all=1

" Color scheme configuration
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai
highlight Normal ctermbg=none
highlight NonText ctermbg=none

set directory=$HOME/.vim/cache

" Indentation style for C++ and Python source code
let g:indentationFileTypes = map(['h', 'cc', 'cpp', 'py', 'sh', 'json', 'yaml', 'yml'], '"*." . v:val')
execute "au BufNewFile,BufRead " . join(g:indentationFileTypes, ",") . " set tabstop=2"
execute "au BufNewFile,BufRead " . join(g:indentationFileTypes, ",") . " set softtabstop=2"
execute "au BufNewFile,BufRead " . join(g:indentationFileTypes, ",") . " set shiftwidth=2"
execute "au BufNewFile,BufRead " . join(g:indentationFileTypes, ",") . " set textwidth=79"
execute "au BufNewFile,BufRead " . join(g:indentationFileTypes, ",") . " set expandtab"
execute "au BufNewFile,BufRead " . join(g:indentationFileTypes, ",") . " set autoindent"
execute "au BufNewFile,BufRead " . join(g:indentationFileTypes, ",") . " set fileformat=unix"

" Tab setting for golang source files
execute "au BufNewFile,BufRead *.go set tabstop=2"
execute "au BufNewFile,BufRead *.go set shiftwidth=2"

" Tab setting for Makefiles
execute "au BufNewFile,BufRead Makefile set tabstop=2"
execute "au BufNewFile,BufRead *.go set shiftwidth=2"

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>i <Plug>(go-install)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>gd <Plug>(go-def-tab)
autocmd FileType go nmap <leader>gb <Plug>(go-def-split)
autocmd FileType go nmap <leader>gv <Plug>(go-def-vertical)

autocmd FileType go nmap <leader>tb :TagbarToggle<cr>

let g:go_fmt_command = "goimports"
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

set autowrite

autocmd BufWritePre * :%s/\s\+$//e

" NERDTree configurations
" " Avoid showing pyc files
let NERDTreeIgnore = [ '\.pyc$' ]

if $TMUX == ''
  set clipboard=unnamed
endif

if &diff
  colo industry
endif

" Configuraiton for UltiSnips
let g:UltiSnipsExpandTrigger="<c-e>"

" Shortcuts for quickfix list
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Always use `quickfix` list instead of `location` list
let g:go_list_type = "quickfix"

" Bindings for tab pages
nnoremap gc :tabclose<CR>

" Disable F1 built-in help key
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" Let F5 do what F5 does
nmap <F5> :checktime<CR>

nmap zz ZZ

inoremap jk <esc>
inoremap kj <esc>
