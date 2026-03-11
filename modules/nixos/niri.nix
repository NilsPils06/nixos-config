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
        wlr.enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal
          xdg-desktop-portal-gtk
        ];
      };

      programs.regreet.enable = true;
      services.greetd = {
        enable = true;
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
        media-downloader
        imv
        mpv
      ];

      programs.niri = {
        enable = true;
        package = pkgs.niri-stable;
      };
    };
}
