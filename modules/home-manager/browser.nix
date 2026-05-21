{ ... }:
{
  flake.modules.homeManager.browser =
    { pkgs, ... }:
    {
      programs.firefox = {
        enable = true;
        configPath = ".mozilla/firefox";
        profiles.default = {
          id = 0;
          isDefault = true;
        };
      };
    };
}
