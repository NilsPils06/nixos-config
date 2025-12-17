# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
        networking.hostName = "scylla";

        # Enable Gnome and all packages around it
        gnome.enable = true;
        gnome-apps.enable = true;

        nixpkgs.overlays = [ (final: prev: {
                inherit (prev.lixPackageSets.stable)
                nixpkgs-review
                nix-eval-jobs
                nix-fast-build
                colmena;
        }) ];

        nix.package = pkgs.lixPackageSets.stable.lix;

        # Allow unfree packages
        nixpkgs.config.allowUnfree = true;

        # Enable networking
        networking.networkmanager.enable = true;

        imports = [
                ./../../modules/nixos
        ];
        services = {
                envfs.enable = true;
                fwupd.enable = true;
        };
        security.rtkit.enable = true;

        # Define a user account. Don't forget to set a password with ‘passwd’.
        users.users.nils = {
                isNormalUser = true;
                description = "Nils Van de Velde";
                extraGroups = [ "networkmanager" "wheel" ];
        };
        locale.language = "irish";

        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
                # Media
                gimp # GNU Image Manipulation Program

                # Documents
                # gramps # Geneology
                # libreoffice # Office Suite

                # Back-ups
                deja-dup 
        ];

        boot = {
                kernelPackages = pkgs.linuxPackages_latest;
                loader = {
                        systemd-boot.enable = true;
                        efi.canTouchEfiVariables = true;
                };
        };

        # Do not change me unless you know what you are doing!! Check documentation first!!
        system.stateVersion = "25.05"; # Did you read the comment?

        # Enable Flakes
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
	 services.postgresql = {
		  enable = true;
		  ensureDatabases = [ "mydatabase" ];
		  enableTCPIP = true;
		  # port = 5432;
		  authentication = pkgs.lib.mkOverride 10 ''
		    #type database DBuser origin-address auth-method
		    local all      all     trust
		    # ... other auth rules ...

		    # ipv4
		    host  all      all     127.0.0.1/32   trust
		    # ipv6
		    host  all      all     ::1/128        trust
		  '';
		  initialScript = pkgs.writeText "backend-initScript" ''
		    CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
		    CREATE DATABASE nixcloud;
		    GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
		  '';
	};
}
