{
        description = "The main flake";

        inputs = {
                home-manager = {
                        url = "github:nix-community/home-manager/master";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                gruvbox-icons = {
                        url = "github:SylEleuth/gruvbox-plus-icon-pack/master";
                        flake = false;
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
                nvf = {
                        url = "github:NotAShelf/nvf/ea3ee477fa1814352b30d114f31bf4895eed053e";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
        };

        outputs = {
                gruvbox-icons,
                home-manager,
                nix-index-database,
                nixpkgs,
                nixpkgs-stable,
                nvf,
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

                        # Neovim config using NVF
                        my-neovim-pkg = (nvf.lib.neovimConfiguration {
                                pkgs = nixpkgs.legacyPackages."${system}";
                                modules = [ ./nvf-configuration.nix ];
                        }).neovim;

                        # Gruvbox icon pack derivation
                        gruvboxPlusIcons = pkgs.callPackage ./packages/gruvbox-plus-icons.nix {
                                inherit gruvbox-icons system;
                        };

                in {
                        # Default app for `nix run .`
                        defaultApp."${system}" = {
                                type = "app";
                                program = "${my-neovim-pkg}/bin/nvim";
                        };

                        nixosConfigurations = {
                                
                                 scylla = lib.nixosSystem {
                                        inherit system;
                                        modules = [
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
                                                                my-neovim-pkg
                                                        ];
                                                }
                                        ];
                                        extraSpecialArgs = {
                                                inherit pkgs-stable gruvboxPlusIcons;
                                        };
                                };
                                "nils@kotoamatsukami" = home-manager.lib.homeManagerConfiguration {
                                        inherit pkgs;
                                        modules = [
                                                ./hosts/kotoamatsukami/home.nix
                                                {
                                                        home.packages = [
                                                                my-neovim-pkg
                                                        ];
                                                }
                                        ];
                                        extraSpecialArgs = {
                                                inherit pkgs-stable gruvboxPlusIcons;
                                        };
                                };
                        };
                };
}

