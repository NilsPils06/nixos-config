{ lib, ...}: {
        imports = [
                ./cliApps/fastfetch.nix
                ./cliApps/git.nix
                ./cliApps/shell.nix

                ./theming/gnome-extensions.nix
                ./theming/gnome-theming.nix
        ];
        git.enable = lib.mkDefault true;

}
