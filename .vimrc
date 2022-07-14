let mapleader = ","
inoremap jk <Esc>
nnoremap ,sp "+p

set nocompatible
set cmdheight=1
set cursorline
set showcmd  "Shows You The typed Commands
let &guifont='Dank Mono:h11' "Settings for Gvim
set number "Line numbers are cool
set hlsearch "Highlight your search
set ignorecase
set incsearch
set hidden
set smartcase
set noerrorbells
set background=dark
set belloff=esc
"Tab Settings
set tabstop=2
set softtabstop=2
set shiftwidth=4
set expandtab
"Helps Reading code
set nowrap
set noswapfile
set mouse=a
set termguicolors
set splitright splitbelow "Explicitly set the direction of split
set autoindent
"Path expansion for vimgrep, grep
set path+=**
"Bash like autocomplete.
set wildmenu
set wildmode=longest:full,full
"The window size for :terminal cmd
if !has("nvim")
    set termwinsize=14*0
endif
let &t_SI = "\e[3 q"
let &t_EI = "\e[1 q"
autocmd BufRead,BufNewFile *.md,*.txt setlocal wrap
autocmd filetype markdown set spell

if has("nvim")
  " Terminal Function
  set guicursor=n-v:block,i-ci-c:hor5
  let g:term_buf = 0
  let g:term_win = 0
  function! TermToggle(height)
      if win_gotoid(g:term_win)
          hide
      else
          botright new
          exec "resize " . a:height
          try
              exec "buffer " . g:term_buf
          catch
              call termopen($SHELL, {"detach": 0})
              let g:term_buf = bufnr("")
              set nonumber
              set norelativenumber
              set signcolumn=no
          endtry
          startinsert!
          let g:term_win = win_getid() endif
  endfunction

" Toggle terminal on/off (neovim)
  nnoremap <A-t> :call TermToggle(12)<CR>
  inoremap <A-t> <Esc>:call TermToggle(12)<CR>
  tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

  " Terminal go back to normal mode
  tnoremap <Esc> <C-\><C-n>
  tnoremap :q! <C-\><C-n>:q!<CR>
endif

colo jellybeans

" Personal Mappings

nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>fi :Files<CR>
nnoremap <Leader>mr :FZFMru<CR>
nnoremap <F8> :Vista coc<CR>
nnoremap <Leader>bu :Buffers<CR>
nnoremap <Leader>pin :PlugInstall<CR>
nnoremap <Leader>vrc :edit ~/.vimrc<CR>
nnoremap <A-f> :Format<CR>
nnoremap <A-b> :w <bar> %bd <bar> e# <bar> bd# <CR><CR>
nnoremap ,sp "+p
inoremap jk <Esc>
nnoremap <Leader>ts :TestSuite<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>tt :TestNearest<CR>
command! Sq :Startify
let g:vimspector_enable_mappings = 'HUMAN'

function! RefreshPlugins() abort
    mark V
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif

    if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) 
        PlugInstall --sync 
    endif
endfunction

autocmd BufWritePost $HOME/.vimrc call RefreshPlugins() | source $HOME/.vimrc | mark V

autocmd VimEnter * call RefreshPlugins()

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'bluz71/vim-moonfly-colors'
Plug 'tpope/vim-dispatch'
Plug 'puremourning/vimspector'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'liuchengxu/vista.vim'
Plug 'preservim/nerdtree'
Plug 'itchyny/calendar.vim'
Plug 'felipec/notmuch-vim'
Plug 'dhruvasagar/vim-dotoo'
Plug 'ryanoasis/vim-devicons'
Plug 'markonm/traces.vim'
Plug 'alpertuna/vim-header'
Plug 'gpanders/vim-medieval'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'cseelus/vim-colors-lucid'
Plug 'tpope/vim-surround'
Plug 'searleser97/cpbooster.vim'
Plug 'mboughaba/i3config.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'pbogut/fzf-mru.vim'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'vifm/vifm.vim'
"Plug 'ludovicchabant/vim-gutentags' "Requires Uni/Ex Ctags
"Plug 'liuchengxu/vim-which-key'
Plug 'sheerun/vim-polyglot'
Plug 'vim-test/vim-test'
call plug#end()            " required

let $FZF_DEFAULT_COMMAND = 'find .'

"Enable Rg to filter node-modules and other files.
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg -g '!design/' -g '!dist/' -g '!pnpm-lock.yaml' -g '!.git' -g '!node_modules' --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--exact --delimiter : --nth 4..'}), <bang>0)

if !empty(glob('~/.vim/plugged/coc.nvim'))
  set nobackup
  set nowritebackup
  set cmdheight=1
  set updatetime=300
  set shortmess+=c
  if has("nvim-0.5.0") || has("patch-8.1.1564")
    set signcolumn=number
  else
    set signcolumn=yes
  endif
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  autocmd CursorHold * silent call CocActionAsync('highlight')

  nmap <leader>rn <Plug>(coc-rename)

  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup autocmd! " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Run the Code Lens action on the current line.
  nmap <leader>cl  <Plug>(coc-codelens-action)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocActionAsync('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
endif

let g:vifm_embed_term = 1
let g:vifm_embed_split = 1

let g:header_field_author_email = 'mximpaid@gmail.com'
let g:header_field_author = 'Manash Baul'
let g:header_auto_add_header = 0
let g:header_field_modified_timestamp = 0
let g:header_field_modified_by = 0


let g:medieval_langs = ['python=python3', 'ruby', 'sh', 'bash', 'javascript=node', 'vim=vim -s']

let g:dotoo#capture#refile = expand('~/dotoo/refile.dotoo')
let g:dotoo#capture#clock = 0
let g:dotoo#agenda#files = ['~/dotoo/*.dotoo']

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_folding = 'expr'
let g:airline#extensions#tabline#enabled = 1
