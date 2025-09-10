{
  description = "The main flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    asus-numberpad-driver = {
      url = "github:asus-linux-drivers/asus-numberpad-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-bash-scripts = {
      url = "github:CouldBeMathijs/bash-scripts";
      flake = false;
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, asus-numberpad-driver, nix-index-database, my-bash-scripts, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      my-bash-scripts-pkg = pkgs.stdenv.mkDerivation {
        pname = "my-bash-scripts";
        version = "1.0.0";
        src = my-bash-scripts;
        installPhase = ''
          mkdir -p $out/bin
        
          for script in $src/*.sh; do
            base_name=$(basename "$script" .sh)
            cp "$script" "$out/bin/$base_name"
            chmod +x "$out/bin/$base_name"
          done
        '';
      };
    in {
      nixosConfigurations = {
        athena = lib.nixosSystem {
          inherit system;
          modules = [
            asus-numberpad-driver.nixosModules.default
            ./configuration.nix
            nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
          ];
        };
      };

      homeConfigurations = {
        mathijs = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            { home.packages = [ my-bash-scripts-pkg ]; }
          ];
        };
      };
    };
}
