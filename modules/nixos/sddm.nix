{ ... }:
{
  flake.modules.nixos.sddm =
    { pkgs, lib, ... }:
    let
      sddm-astronaut = pkgs.sddm-astronaut.override {
        embeddedTheme = "japanese_aesthetic";
      };
    in
    {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        package = pkgs.kdePackages.sddm;
        theme = "sddm-astronaut-theme";
        extraPackages = with pkgs.kdePackages; [
          sddm-astronaut
          qtmultimedia
          qtsvg
          qtvirtualkeyboard
          qt5compat
        ];
      };

      environment.systemPackages = [
        sddm-astronaut
      ];
    };
}
