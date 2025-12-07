{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        apps.default = flake-utils.lib.mkApp {
          drv = pkgs.writeShellApplication {
            name = "run-live-server";
            text = ''
              ${pkgs.nodePackages.live-server}/bin/live-server src --mount=/public:public
            '';
          };
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "website";
          version = "0.0.0";
          src = ./.;

          installPhase = ''
            mkdir -p $out
            cp -r public $out
            cp -r src/* $out
          '';
        };

        devShell = pkgs.mkShell { buildInputs = with pkgs; [ nodePackages.prettier ]; };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
