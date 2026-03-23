{ self, ... }:
let
  hostname = "kotoamatsukami";
  modules = with self.modules.nixos; [
    common
    audio
    cli-utils
    fonts
    locale
    nh
    niri
    noctalia
    plymouth
    stylix
  ];
  hmModules = with self.modules.homeManager; [
    shell
    fastfetch
    git
    browser
    discord
    minecraft
    niri
    noctalia
    stylix
    zed
    direnv
  ];
in
{
  flake = {
    nixosConfigurations.${hostname} = self.lib.mkNixosHost { inherit hostname modules hmModules; };

    modules = {
      nixos.${hostname} =
        { pkgs, ... }:
        {
          services = {
            envfs.enable = true;
            fwupd.enable = true;

            postgresql = {
              enable = true;
              ensureDatabases = [ "mydatabase, matchup, matchup_test" ];
              enableTCPIP = true;
              authentication = pkgs.lib.mkOverride 10 ''
                local all      all     trust
                host  all      all     127.0.0.1/32   trust
                host  all      all     ::1/128        trust
              '';
              initialScript = pkgs.writeText "backend-initScript" ''
                CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
                CREATE DATABASE nixcloud;
                GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
              '';
            };
          };

          xdg.portal.enable = true;

          boot.kernelPackages = pkgs.linuxPackages_latest;

          programs.steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
          };
        };

      homeManager.${hostname} =
        { pkgs, ... }:
        {
          home.homeDirectory = "/home/nils";
          home.username = "nils";
          home.stateVersion = "25.05";
          home.packages = with pkgs; [
            obs-studio # Record your screen
            audacity # Audio recording and editing
            shotcut # Video editing
          ];

          xdg.enable = true;
          programs.home-manager.enable = true;
        };
    };
  };
}
