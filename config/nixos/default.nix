{
  config,
  pkgs,
  plugins,
  ...
}:
{
  imports = [ plugins ];
  config = {
    programs = {
      vim =
        let
          inherit (config.myPlugins)
            beacon
            deoplete
            vim-fzf
            vim-lightline
            ;
        in
        {
          enable = true;
          package = (
            (pkgs.vim_configurable.override { }).customize {
              name = "vim";
              # Install plugins for example for syntax highlighting of nix files
              vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
                start = [
                  ale
                  beacon
                  deoplete
                  delimitMate
                  colors-solarized
                  nerdcommenter
                  vim-tmux-navigator
                  lightline-ale
                  vim-fzf
                  vim-lightline
                ];
                opt = [ ];
              };
              vimrcConfig.customRC = ''
                let mapleader = ","
                " plugins
                " ale
                let g:ale_rust_cargo_default_feature_behaviour = 'all'
                let g:ale_rust_cargo_use_clippy = 1
                let g:ale_fix_on_save = v:true
                let g:ale_floating_preview = 1
                let g:ale_lint_on_text_changed = 'always'
                let g:ale_fixers = {
                \   '*': ['remove_trailing_lines', 'trim_whitespace'],
                \   'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace'],
                \   'nix': ['nixfmt', 'remove_trailing_lines', 'trim_whitespace'],
                \}
                nmap K :ALEHover<CR>
                nmap gd :ALEGoToDefinitionInVSplit<CR>
                nmap gr :ALEFindReferences<CR>

                " beacon
                nmap n n:Beacon<cr>
                nmap N N:Beacon<cr>
                nmap * *:Beacon<cr>
                nmap # #:Beacon<cr>

                " lightline
                set background=dark
                let g:lightline = {
                      \ 'colorscheme': 'solarized',
                      \ }
                let g:lightline.component_expand = {
                      \  'linter_checking': 'lightline#ale#checking',
                      \  'linter_infos': 'lightline#ale#infos',
                      \  'linter_warnings': 'lightline#ale#warnings',
                      \  'linter_errors': 'lightline#ale#errors',
                      \  'linter_ok': 'lightline#ale#ok',
                      \ }
                let g:lightline.component_type = {
                       \     'linter_checking': 'right',
                       \     'linter_infos': 'right',
                       \     'linter_warnings': 'warning',
                       \     'linter_errors': 'error',
                       \     'linter_ok': 'right',
                       \ }
                let g:lightline.active = {
                      \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
                      \            [ 'lineinfo' ],
                     \            [ 'percent' ],
                     \            [ 'fileformat', 'fileencoding', 'filetype'] ] }

                " nerdcommenter
                let g:NERDCreateDefaultMappings = 1
                let NERDSpaceDelims=1

                " deoplete
                call deoplete#custom#option('sources', {
                \ '_': ['ale'],
                \})

                " maps
                imap jj <ESC>

                " Fast quit
                nmap q :q<CR>

                " Shebang
                nmap ! i#!/bin/sh<ESC>

                " Backspace
                map <BS> dh

                " Save file
                imap w! <ESC>:w!
                nmap w! :w!

                " Mark paragraph
                map <F2> vip

                " open fzf
                map ; :Files<CR>
                set rtp+=${pkgs.fzf}/share/vim-plugins/fzf

                " opts
                " Indentation
                set autoindent

                " Automatically change dirs when visiting files
                set autochdir

                " Enable normal backspace behaviour
                set backspace=2

                " Tabs are evil
                set expandtab

                set number

                set relativenumber

                " Not too deep, not too shallow
                set shiftwidth=2

                " Tabs are 2 characters
                set tabstop=2

                set nocompatible
                " we don't need this with lightline
                set noshowmode

                " Tabs are 2 characters
                set tabstop=2

                " Show columnnumbers
                set ruler

                " Enable syntax highlighting
                syntax on

                " Set formatting of text and comments
                set formatoptions=tn1

                " Highlight matches
                set hlsearch

                " Always want statusline
                set laststatus=2

                " We want fancy tab handling
                set smarttab

                " Encoding
                set encoding=utf-8
                set termencoding=utf-8
                set fileencoding=utf-8

                :filetype plugin indent on

                " When editing a file, always jump to the last known cursor position.
                " Don't do it when the position is invalid or when inside an event handler
                " (happens when dropping a file on gvim).
                autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
              '';
            }
          );
        };
    };
  };
}
