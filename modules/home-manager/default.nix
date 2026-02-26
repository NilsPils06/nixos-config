{ lib, ... }:
{
  imports = [
    ./cli-apps/fastfetch.nix
    ./cli-apps/git.nix
    ./cli-apps/shell.nix
    ./programs/browser.nix
    ./programs/discord.nix
    ./programs/jetbrains.nix
    ./programs/minecraft.nix
    ./programs/noctalia.nix
    ./theming/stylix.nix
    ./theming/niri.nix
  ];
  browser.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
}
