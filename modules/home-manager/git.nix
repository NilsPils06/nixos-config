{ ... }:
{
  flake.modules.homeManager.git =
    { pkgs, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user.name = "NilsPils06";
          user.email = "135322818+NilsPils06@users.noreply.github.com";
          init.defaultBranch = "main";
          credential.helper = "${pkgs.gh}/bin/gh auth git-credential";
        };
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };
    };
}
