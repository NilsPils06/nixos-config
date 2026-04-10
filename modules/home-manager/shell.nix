{ ... }:
{
  flake.modules.homeManager.shell =
    { config, pkgs, ... }:
    let
      flake = "${config.home.homeDirectory}/.dotfiles";

      ytm-dl = pkgs.writeShellApplication {
        name = "ytm-dl";
        runtimeInputs = with pkgs; [ yt-dlp ffmpeg ];
        text = ''
          if [ -z "$1" ]; then
            echo "Fout: Geen URL opgegeven."
            echo "Gebruik: ytm-dl <youtube-music-url>"
            exit 1
          fi

          # yt-dlp commando met jouw specifieke eisen
          yt-dlp \
            --extract-audio \
            --audio-format mp3 \
            --audio-quality 0 \
            --embed-metadata \
            --embed-thumbnail \
            --output "%(title)s.%(ext)s" \
            "$1"
        '';
      };
    in
    {
      home.packages = with pkgs; [
        bat # Better cat
        eza # Better ls
        trash-cli # rm on safe mode
        tldr # When man is overkill
        zoxide # cd^2
        ytm-dl
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
