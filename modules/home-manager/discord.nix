{ ... }:
{
  flake.modules.homeManager.discord =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        vesktop
      ];
      xdg = {
        enable = true;
        desktopEntries."vesktop" = {
          name = "Vesktop";
          comment = "A Discord client";
          genericName = "Discord Client";
          exec = "vesktop";
          type = "Application";
          icon = "discord";
        };
        autostart = {
          enable = true;
          entries = [ "${config.home.homeDirectory}/.nix-profile/share/applications/vesktop.desktop" ];
        };
      };
    };
}
