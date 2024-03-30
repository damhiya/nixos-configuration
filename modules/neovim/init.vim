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
let g:neovide_scroll_animation_length = 0.05

" lightline
set laststatus=2

" nvim-treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  sync_install = false,
  auto_install = false,
  highlight = { enable = true },
  additional_vim_regex_highlighting = false
}
EOF

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
