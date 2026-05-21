{ ... }:
{
  flake.modules.homeManager.direnv =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        kdePackages.kdenlive
        wl-screenrec
      ];
    };
}
