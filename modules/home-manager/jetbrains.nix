{ ... }:
{
  flake.modules.homeManager.jetbrains =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jetbrains.pycharm
        jetbrains.clion
      ];
    };
}
