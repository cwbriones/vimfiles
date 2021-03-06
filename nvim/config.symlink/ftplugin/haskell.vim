set softtabstop=4
set shiftwidth=4

set wildignore+=*\\tmp,.cabal-sandbox

let g:haskell_tabular = 1
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0

autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd BufWritePost *.hs GhcModCheckAndLintAsync

map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>
