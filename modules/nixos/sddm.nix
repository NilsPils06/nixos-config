{ ... }:
{
  flake.modules.nixos.sddm =
    { pkgs, lib, ... }:
    {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        extraPackages = with pkgs.kdePackages; [
          qtmultimedia
          qtsvg
          qtvirtualkeyboard
          qt5compat
        ];
      };

      environment.systemPackages = with pkgs; [
        sddm-astronaut
      ];
    };
}
