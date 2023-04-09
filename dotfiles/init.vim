set number
set hlsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set mouse=a                                                                     
set textwidth=80
"set wildmode=longest,list "bashlike tab completions
set cc=+1 "20"	"set 80 colum border for coding style
highlight ColorColumn ctermbg=8 
syntax on
set cursorline	"highlight current cursorline
set noswapfile
set nowrap
set relativenumber
set termguicolors
"set clipboard+=unnamedplus


"Clipboard mapping"
"
"" Copy to clipboard
vnoremap  <C-y>  "+y
nnoremap  <C-Y>  "+yg_
nnoremap  <C-y>  "+y
"nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <C-p> "+p
nnoremap <C-P> "+P
vnoremap <C-p> "+p
vnoremap <C-P> "+P


"Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'SirVer/ultisnips'
"Plug 'SirVer/ultisnips',{'commit':'e1ae43e'}
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim' 
Plug 'lervag/vimtex'
Plug 'honza/vim-snippets'
Plug 'EdenEast/nightfox.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'arcticicestudio/nord-vim'
Plug 'lukas-reineke/indent-blankline.nvim'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()

"Activating nvim-colorizer.lua

lua require 'colorizer'.setup()
lua require 'colorizer'.setup(nil, { css = true; })

"Colorscheme
colorscheme carbonfox     

"let g:plug_timeout = 300 
" Snippets triggers
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger ='jk' "was: <c-j>'
let g:UltiSnipsJumpBackwardTrigger ='kj' "was: <c-k>'
let g:UltiSnipsEditSplit ='vertical'
"let g:UltiSnipsSnippetDirectories = ["mySnippets"]
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/mySnippets']

"Vimtex Configuration
filetype plugin on
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=2
let g:tex_conceal='abdmg'
hi! link Conceal Normal
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \    '-shell-escape',
    \    '-verbose',
    \    '-file-line-error',
    \    '-synctex=1',
    \    '-interaction=nonstopmode',
    \ ],
    \}

"Indent-blankline setup
let g:indent_blankline_filetype = ['vim', 'tex', 'html', 'c', 'cpp', 'java', 'python']
highlight IndentBlanklineChar guifg=#755f05 gui=nocombine
