{ ... }:
{
  flake.modules.homeManager.stylix =
    { pkgs, config, ... }:
    {
      # De basis-instellingen (thema, wallpaper) zijn weggelaten,
      # want die neemt hij nu automatisch over van je NixOS configuratie!

      stylix.image = pkgs.lib.mkForce ../../img/stylix/wallpaper.jpg;

      stylix.targets = {
        gtk.enable = true;
        gnome.enable = true;
        kitty.enable = true;
        niri.enable = true;
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
