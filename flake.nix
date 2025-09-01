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
	};

	outputs = { self, nixpkgs, home-manager, asus-numberpad-driver, ... }:
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			athena = lib.nixosSystem {
				inherit system;
				modules = [
					asus-numberpad-driver.nixosModules.default 
					./configuration.nix
				];
			};
		};

		homeConfigurations = {
			mathijs = home-manager.lib.homeManagerConfiguration {				
				inherit pkgs;
				modules = [ ./home.nix ];
			};
		};
	};
}
