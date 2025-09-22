{ lib, ...}: {
        imports = [
                ./cliApps/fastfetch.nix
                ./cliApps/git.nix
                ./cliApps/shell.nix

                ./theming/gnome-extensions.nix
                ./theming/gnome-theming.nix
                ./programs/minecraft.nix
                ./programs/browser.nix
                ./programs/jetbrains.nix
        ];
        git.enable = lib.mkDefault true;
        browser.enable = lib.mkDefault true;
}
