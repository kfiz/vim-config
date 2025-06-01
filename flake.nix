{
  description = "Doro's home-manager vim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    beacon = {
      url = "github:DanilaMihailov/beacon.nvim/v1.3.4";
      flake = false;
    };
    vim-lightline = {
      url = "github:itchyny/lightline.vim";
      flake = false;
    };
    vim-fzf = {
      url = "github:junegunn/fzf.vim";
      flake = false;
    };
    deoplete = {
      url = "github:Shougo/deoplete.nvim";
      flake = false;
    };
  };

  outputs =
    inputs:
    with inputs;
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;
      imports = [
        inputs.home-manager.flakeModules.home-manager
        inputs.treefmt-nix.flakeModule
      ];
      flake = {
        homeModules.default = { pkgs, ... }: import ./default.nix { inherit pkgs inputs; };
      };
      perSystem = {
        treefmt.programs.nixfmt.enable = true;
      };
    };
}
