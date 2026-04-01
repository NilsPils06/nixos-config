{ ... }:
{
  flake.modules.homeManager.shell =
    { config, pkgs, ... }:
    let
      flake = "${config.home.homeDirectory}/.dotfiles";
    in
    {
      home.packages = with pkgs; [
        bat # Better cat
        eza # Better ls
        trash-cli # rm on safe mode
        tldr # When man is overkill
        zoxide # cd^2
      ];
      programs.bash.enable = false;
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        dotDir = "${config.xdg.configHome}/zsh";

        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initContent = "fastfetch";

        shellAliases = {
          ".." = "cd ..";
          "cat" = "bat";
          "clear" = "clear; fastfetch";
          "ll" = "eza -l";
          "ls" = "eza";
          "open" = "xdg-open";
          "switch" = "git add .; nh os switch";
          "rstudio" = "QT_QPA_PLATFORM=xcb rstudio";
        };
      };
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
      };
      programs.kitty = {
        enable = true;
      };
      stylix.targets.kitty.enable = true;
      xdg = {
        enable = true;
        desktopEntries."btop" = {
          name = "btop++";
          noDisplay = true;
        };
      };
    };
}
