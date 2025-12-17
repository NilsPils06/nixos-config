{ lib, ...}: {
        imports = [
                ./cli-apps/fastfetch.nix
                ./cli-apps/git.nix
                ./cli-apps/shell.nix
                ./programs/browser.nix
                ./programs/discord.nix
                ./programs/jetbrains.nix
                ./programs/minecraft.nix
                ./theming/gnome-extensions.nix
                ./theming/gnome-stylix.nix
        ];
        browser.enable = lib.mkDefault true;
        git.enable = lib.mkDefault true;
}
