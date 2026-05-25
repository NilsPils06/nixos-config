{ ... }:
{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        # Nerd fonts
        nerd-fonts.jetbrains-mono
      ];
    };
}
