{
        description = "The main flake";

        inputs = {
                home-manager = {
                        url = "github:nix-community/home-manager/master";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                nixpkgs = {
                        url = "github:NixOS/nixpkgs/nixos-unstable";
                };
                nixpkgs-stable = {
                        url = "github:NixOS/nixpkgs/release-25.05";
                };
                nix-index-database = {
                        url = "github:nix-community/nix-index-database";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                stylix = {
                        url = "github:nix-community/stylix/master";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
        };

        outputs = {
                home-manager,
                nix-index-database,
                nixpkgs,
                nixpkgs-stable,
                stylix,
                ...
                }:
                let
                        system = "x86_64-linux";
                        lib = nixpkgs.lib;

                        pkgs = import nixpkgs {
                                inherit system;
                                config.allowUnfree = true;
                        };

                        pkgs-stable = import nixpkgs-stable {
                                inherit system;
                                config.allowUnfree = true;
                        };

                in {
                        nixosConfigurations = {
                                 scylla = lib.nixosSystem {
                                        inherit system;
                                        modules = [
                                        	stylix.nixosModules.stylix
                                                ./hosts/scylla/hardware-configuration.nix
                                                ./hosts/scylla/configuration.nix
  
                                                nix-index-database.nixosModules.nix-index
                                                { programs.nix-index-database.comma.enable = true; }
                                        ];
                                        specialArgs = {
                                                inherit pkgs-stable;
                                        };
                                };
                                kotoamatsukami = lib.nixosSystem {
                                        inherit system;
                                        modules = [
                                                ./hosts/kotoamatsukami/hardware-configuration.nix
                                                ./hosts/kotoamatsukami/configuration.nix
  
                                                nix-index-database.nixosModules.nix-index
                                                { programs.nix-index-database.comma.enable = true; }
                                        ];
                                        specialArgs = {
                                                inherit pkgs-stable;
                                        };
                                };
                        };
                        homeConfigurations = {
                                "nils@scylla" = home-manager.lib.homeManagerConfiguration {
                                        inherit pkgs;
                                        modules = [
                                                ./hosts/scylla/home.nix
                                                {
                                                        home.packages = [
                                                        ];
                                                }
                                                stylix.homeModules.stylix
                                        ];
                                        extraSpecialArgs = {
                                                inherit pkgs-stable;
                                        };
                                };
                                "nils@kotoamatsukami" = home-manager.lib.homeManagerConfiguration {
                                        inherit pkgs;
                                        modules = [
                                                ./hosts/kotoamatsukami/home.nix
                                                {
                                                        home.packages = [
                                                        ];
                                                }
                                        ];
                                        extraSpecialArgs = {
                                                inherit pkgs-stable;
                                        };
                                };
                        };
                };
}

