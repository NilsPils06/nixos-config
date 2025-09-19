{ pkgs, lib, config, options, ... }:
let
        flake = options.flake-path;
in
        {
        options = {
                shell.enable = lib.mkEnableOption "enable shell";
        };

        config = lib.mkIf config.shell.enable {
                home.packages = with pkgs; [
                        bat # Better cat
                        eza # Better ls
                        trash-cli # rm on safe mode
                        tldr # When man is overkill
                        zoxide # cd^2
                ];
                # Shell configuration
                programs.bash = {
                        enable = true;
                        initExtra = "fastfetch";
                        shellAliases = {
                                "z" = "zoxide";
                                "cat" = "bat";
                                "clear" = "clear; fastfetch";
                                "ls" = "eza";
                                "ll" = "eza -l";
                                ".." = "cd ..";
                                "switch-home" = "home-manager switch --print-build-logs --verbose --flake ${flake} && nh clean user --keep-since 3d --keep 5";
                                "flake-update" = "nix flake update --flake ${flake}";
                                "switch-all" = "nh os switch ${flake} && home-manager switch --print-build-logs --verbose --flake ${flake} && nh clean user --keep-since 3d --keep 5";
                                # "topgrade" = "nix flake update --flake ${flake} && nh os switch ${flake} && nh home switch ${flake} && nh clean user --keep-since 3d --keep 5";
                        };
                };
                programs.zoxide = {
                        enable = true;
                        enableBashIntegration = true;
                };
        };
}
