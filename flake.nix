{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/31ffc50c";
    flake-utils.url = "github:numtide/flake-utils/7e5bf3925";
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = nixpkgs.legacyPackages.${system};
  in
  rec {
    packages = flake-utils.lib.flattenTree {
      hcssmith =  let lib = pkgs.lib; in
      pkgs.stdenv.mkDerivation rec {
        pname = "hcssmith.com";
        version = "development";
        
        phases = ["preparePhase" "installPhase"];

        home = (import ./lib/genHome.nix).genHome (import ./site.nix);

        preparePhase = ''
          mkdir -p $out
          '';
        installPhase = ''
          cp ${home} $out/index.html
        '';

        src = ./.;
      };
    };

    defaultPackage = packages.hcssmith;
    defaultApp = packages.hcssmith;


  }
  );
}
