{ self, ... }:
let
  pkgs-stable = import self.inputs.nixpkgs-stable {
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
      self.inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ../hosts/${hostname}/hardware-configuration.nix
            self.modules.nixos.${hostname}
            {
              networking.hostName = hostname;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit pkgs-stable;
                  inherit (self.inputs) noctalia niri stylix;
                };
                users.nils = {
                  imports =
                    [
                      self.modules.homeManager.${hostname}
                      self.inputs.stylix.homeModules.stylix
                      self.inputs.noctalia.homeModules.default
                    ]
                    ++ hmModules;
                };
              };
            }

            # Flake-provided NixOS modules
            self.inputs.noctalia.nixosModules.default
            self.inputs.niri.nixosModules.niri
            self.inputs.stylix.nixosModules.stylix
            self.inputs.nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            self.inputs.home-manager.nixosModules.home-manager
          ]
          ++ modules;
        specialArgs = {
          inherit pkgs-stable;
          inherit (self.inputs) noctalia niri;
        };
      };
  };
}
