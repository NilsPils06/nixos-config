{ ... }:
{
  flake.modules.homeManager.browser =
    { pkgs, ... }:
    {
      programs.firefox.enable = true;
    };
}
