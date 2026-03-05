{ ... }:
{
  flake.modules.homeManager.stylix =
    { pkgs, config, ... }:
    {
      stylix.enable = true;

      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";

      stylix.targets = {
        gtk.enable = true;
        gnome.enable = true;
        kitty.enable = true;
        niri.enable = true;
      };

      stylix.fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = config.stylix.fonts.monospace;
        serif = config.stylix.fonts.monospace;
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        sizes.desktop = 11;
      };

      xdg.enable = true;

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

      stylix.polarity = "dark";
    };
}
