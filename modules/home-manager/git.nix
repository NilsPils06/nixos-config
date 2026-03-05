{ ... }:
{
  flake.modules.homeManager.git =
    { pkgs, ... }:
    {
      programs.git = {
        enable = false;
        settings = {
          user = {
            name = "NilsPils06";
            email = "135322818+NilsPils06@users.noreply.github.com";
          };
          init.defaultBranch = "main";
        };
      };
      home.packages = with pkgs; [
        gh # Github client
        git # Duh
      ];
    };
}
