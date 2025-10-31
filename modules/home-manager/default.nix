{ lib, ...}: {
        imports = [
                ./cli-apps/fastfetch.nix
                ./cli-apps/fun-cli.nix
                ./cli-apps/git.nix
                ./cli-apps/shell.nix
                ./programs/browser.nix
                ./programs/discord.nix
                ./programs/jetbrains.nix
                ./programs/latex.nix
                ./programs/minecraft.nix
                ./theming/cinnamon-theming.nix
                ./theming/gnome-extensions.nix
                ./theming/gnome-theming.nix
        ];
        browser.enable = lib.mkDefault true;
        git.enable = lib.mkDefault true;
}
