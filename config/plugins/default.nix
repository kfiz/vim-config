{ inputs, ... }:
{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.myPlugins = lib.genAttrs [
    "beacon"
    "deoplete"
    "vim-fzf"
    "vim-lightline"
  ] (_: (mkOption { type = types.package; }));

  config.myPlugins = {
    beacon = pkgs.vimUtils.buildVimPlugin {
      name = "beacon.nvim";
      src = inputs.beacon;
    };
    deoplete = pkgs.vimUtils.buildVimPlugin {
      name = "deoplete.nvim";
      src = inputs.deoplete;
    };
    vim-fzf = pkgs.vimUtils.buildVimPlugin {
      name = "fzf.vim";
      src = inputs.vim-fzf;
    };
    vim-lightline = pkgs.vimUtils.buildVimPlugin {
      name = "lightline.vim";
      src = inputs.vim-lightline;
    };
  };
}
