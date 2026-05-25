{ ... }:
{
  flake.modules.homeManager.stylix =
    { pkgs, config, ... }:
    {
      stylix.targets = {
        gtk.enable = true;
        gnome.enable = true;
        kitty.enable = true;
        niri.enable = true;
        zed.enable = true;
        firefox.profileNames = [ "default" ];
      };

      stylix.cursor = {
        package = pkgs.capitaine-cursors-themed;
        name = "Capitaine Cursors";
        size = 32;
      };

      stylix.icons = {
        enable = true;
        package = pkgs.nordzy-icon-theme;
        light = "Nordzy";
        dark = "Nordzy";
      };

      gtk.gtk4.theme = config.gtk.theme;
    };
}
