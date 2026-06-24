{ ... }:
{
  flake.modules.homeManager.niri =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        xwayland-satellite
        fuzzel
        brightnessctl
        wireplumber
        matugen
        awww
      ];

      programs.kitty.enable = true;
      wayland.windowManager.hyprland.enable = true;
      home.sessionVariables.NIXOS_OZONE_WL = "1";
    };
}
