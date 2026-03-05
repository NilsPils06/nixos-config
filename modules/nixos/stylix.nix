{ ... }:
{
  flake.modules.nixos.stylix =
    { pkgs, config, ... }:
    {
      stylix.enable = true;
      stylix.image = ../../img/stylix/lightdm.jpg;
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
      stylix.polarity = "dark";

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

      stylix.targets.lightdm.enable = true;
    };
}