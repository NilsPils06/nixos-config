{ self, inputs, ... }:
let
  pkgs-stable = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  flake.lib = {
    mkNixosHost =
      {
        hostname,
        modules ? [ ],
        hmModules ? [ ],
      }:
      inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ../hosts/${hostname}/_hardware-configuration.nix
            self.modules.nixos.${hostname}
            {
              networking.hostName = hostname;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit pkgs-stable;
                  inherit (inputs) noctalia niri stylix;
                };
                users.nils = {
                  imports =
                    [
                      self.modules.homeManager.${hostname}
                      # inputs.stylix.homeModules.stylix
                      inputs.noctalia.homeModules.default
                    ]
                    ++ hmModules;
                };
              };
            }

            # Flake-provided NixOS modules
            inputs.noctalia.nixosModules.default
            inputs.niri.nixosModules.niri
            inputs.stylix.nixosModules.stylix
            inputs.nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            inputs.home-manager.nixosModules.home-manager
          ]
          ++ modules;
        specialArgs = {
          inherit pkgs-stable;
          inherit (inputs) noctalia niri;
        };
      };
  };
}
