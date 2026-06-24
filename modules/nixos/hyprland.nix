{ ... }:
{
  flake.modules.nixos.hyprland =
    { pkgs, ... }:
    {
      services.gvfs.enable = true;

      services.xserver = {
        enable = true;
        excludePackages = with pkgs; [
          xterm
        ];
      };

      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      xdg.icons.enable = true;
      xdg.portal = {
              enable = true;
              extraPortals = with pkgs; [
                xdg-desktop-portal-gtk
                xdg-desktop-portal-gnome
              ];
              config = {
                common = {
                  default = [ "gtk" ];
                };
                niri = {
                  default = [ "gnome" "gtk" ];
                };
              };
            };

      programs.thunar = {
        enable = true;
        plugins = with pkgs; [
          thunar-archive-plugin
          thunar-volman
        ];
      };

      environment.systemPackages = with pkgs; [
        file-roller
        imv
        mpv
      ];

      programs.hyprland = {
        enable = true;
      };

      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
}
