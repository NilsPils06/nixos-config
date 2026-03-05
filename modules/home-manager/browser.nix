{ ... }:
{
  flake.modules.homeManager.browser =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.firefox
      ];
    };
}
