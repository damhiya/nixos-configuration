syntax on
filetype on
filetype plugin indent on
set tabstop=8
set shiftwidth=2
set backspace=2
set expandtab
set background=dark
set number
set cursorline
set mouse=a
set noswapfile
set hlsearch
set cindent
set autoindent
set smartindent
set guifont=Iosevka\ Fixed:h9

" lightline
set laststatus=2

" haskell
let g:haskell_classic_highlighting = 0
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" colorscheme
function! HaskellColor() abort
  hi! link Type GruvboxPurple
  hi! link Operator GruvboxOrange
  hi! link Delimeter GruvboxFg3
  hi! link Keyword GruvboxRed
  hi! link Structure GruvboxAqua
  hi! link Include GruvboxAqua
  hi! link SpecialComment GruvboxYellow

  hi! link haskellType Type
  hi! link haskellAssocType Type
  hi! link haskellIdentifier Identifier
  hi! link haskellSeparator Delimeter
  hi! link haskellDelimiter Delimeter
  hi! link haskellOperators Operator

  hi! link haskellBacktick Operator
  hi! link haskellConditional Conditional

  hi! link haskellDefault Keyword
  hi! link haskellBottom Macro
  hi! link haskellImportKeywords Include

  hi! link haskellDeclKeyword Structure
  hi! link haskellDeriveKeyword Structure
  hi! link haskellDecl Structure
  hi! link haskellWhere Structure
  hi! link haskellLet Structure

  hi! link haskellNumber Number
  hi! link haskellString String
  hi! link haskellChar String
  hi! link haskellPragma SpecialComment
endfunction

autocmd ColorScheme gruvbox call HaskellColor()

let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

nmap <leader>f :NERDTreeToggle<CR>
packadd bufexplorer
nunmap <leader>bv
nunmap <leader>bs
nunmap <leader>bt
nunmap <leader>be
nmap <leader>b :BufExplorer<CR>

set autoread
autocmd FocusGained,BufEnter * :checktime
