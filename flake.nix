{
        description = "The main flake";

        inputs = {
                asus-numberpad-driver = {
                        url = "github:asus-linux-drivers/asus-numberpad-driver";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                home-manager = {
                        url = "github:nix-community/home-manager/master";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                gruvbox-icons = {
                        url = "github:SylEleuth/gruvbox-plus-icon-pack/master";
                        flake = false;
                };
                my-bash-scripts = {
                        url = "github:CouldBeMathijs/bash-scripts";
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
                stylix = {
                        url = "github:nix-community/stylix/master";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                zen-browser = {
                        url = "github:0xc000022070/zen-browser-flake/beta";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
        };

        outputs = {
                asus-numberpad-driver,
                gruvbox-icons,
                home-manager,
                my-bash-scripts,
                nix-index-database,
                nixpkgs,
                nixpkgs-stable,
                nvf,
                stylix,
                zen-browser,
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

                        # Custom bash scripts package
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
                                athena = lib.nixosSystem {
                                        inherit system;
                                        modules = [
                                                ./hosts/athena/hardware-configuration.nix
                                                ./hosts/athena/configuration.nix
                                                asus-numberpad-driver.nixosModules.default
                                                nix-index-database.nixosModules.nix-index
                                                { programs.nix-index-database.comma.enable = true; }
                                        ];
                                        specialArgs = {
                                                inherit pkgs-stable;
                                        };
                                };

                                dionysus = lib.nixosSystem {
                                        inherit system;
                                        modules = [
                                                ./hosts/dionysus/configuration.nix
                                                ./hosts/dionysus/hardware-configuration.nix
                                                nix-index-database.nixosModules.nix-index
                                                { programs.nix-index-database.comma.enable = true; }
                                        ];
                                        specialArgs = {
                                                inherit pkgs-stable;
                                        };
                                };
                                
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
                                "mathijs@athena" = home-manager.lib.homeManagerConfiguration {
                                        inherit pkgs;
                                        modules = [
                                                ./hosts/athena/home.nix
                                                {
                                                        home.packages = [
                                                                my-bash-scripts-pkg
                                                                my-neovim-pkg
                                                        ];
                                                }
                                                stylix.homeModules.stylix
                                        ];
                                        extraSpecialArgs = {
                                                inherit pkgs-stable gruvboxPlusIcons zen-browser;
                                        };
                                };
                                "nils@scylla" = home-manager.lib.homeManagerConfiguration {
                                        inherit pkgs;
                                        modules = [
                                                ./hosts/scylla/home.nix
                                                {
                                                        home.packages = [
                                                                my-bash-scripts-pkg
                                                                my-neovim-pkg
                                                        ];
                                                }
                                                stylix.homeModules.stylix
                                        ];
                                        extraSpecialArgs = {
                                                inherit pkgs-stable gruvboxPlusIcons zen-browser;
                                        };
                                };
                                "nils@kotoamatsukami" = home-manager.lib.homeManagerConfiguration {
                                        inherit pkgs;
                                        modules = [
                                                ./hosts/kotoamatsukami/home.nix
                                                {
                                                        home.packages = [
                                                                my-bash-scripts-pkg
                                                                my-neovim-pkg
                                                        ];
                                                }
                                                stylix.homeModules.stylix
                                        ];
                                        extraSpecialArgs = {
                                                inherit pkgs-stable gruvboxPlusIcons zen-browser;
                                        };
                                };

                                "mathijs@dionysus" = home-manager.lib.homeManagerConfiguration {
                                        inherit pkgs;
                                        modules = [
                                                ./hosts/dionysus/home.nix
                                                {
                                                        home.packages = [
                                                                my-bash-scripts-pkg
                                                                my-neovim-pkg
                                                        ];
                                                }
                                                stylix.homeModules.stylix
                                        ];
                                        extraSpecialArgs = {
                                                inherit pkgs-stable gruvboxPlusIcons zen-browser;
                                        };
                                };
                        };
                };
}

