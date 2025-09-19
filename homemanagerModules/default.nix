{ lib, ...}: {
        imports = [
                ./cliApps/fastfetch.nix
                ./cliApps/shell.nix

                ./theming/gnome-extensions.nix
                ./theming/gnome-theming.nix
        ];
}
