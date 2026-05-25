{ ... }:
{
  flake.modules.nixos.niri =
    { pkgs, niri, ... }:
    {
      nixpkgs.overlays = [ niri.overlays.niri ];

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

      programs.niri = {
        enable = true;
        package = pkgs.niri-stable;
      };
    };
}
