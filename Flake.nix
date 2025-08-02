{
  description = "Seed-&-Fabricate 2.0 - Dierenbos Avontuur";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true; # Nodig voor o.a. CUDA
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Core tools
            (python3.withPackages (ps: with ps; [ click protobuf tqdm numpy pillow ]))
            
            # Build tools
            android-sdk
            flutter
            
            # Media & Infra
            ffmpeg-full
            git
            unzip
            wget
          ];
          
          shellHook = ''
            echo "🌱 Seed-&-Fabricate 2.0 Environment Activated"
            # Hier zouden normaal de echte build commando's komen
            # Voor deze demo simuleren we de output
          '';
        };
      });
}
