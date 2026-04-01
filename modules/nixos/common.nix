{ ... }:
{
  flake.modules.nixos.common =
    { pkgs, lib, ... }:
    {
      nixpkgs.overlays = [
        (final: prev: {
          inherit (prev.lixPackageSets.stable)
            nixpkgs-review
            nix-eval-jobs
            nix-fast-build
            colmena
            ;
        })
      ];
      nix.package = pkgs.lixPackageSets.stable.lix;
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.permittedInsecurePackages = [
        "electron-38.8.4"
      ];

      networking.networkmanager.enable = true;
      security.rtkit.enable = true;
      programs.dconf.enable = true;
      programs.yazi.enable = true;
      programs.zsh.enable = true;

      users.users.nils = {
        isNormalUser = true;
        description = "Nils Van de Velde";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.zsh;
      };

      environment.systemPackages = with pkgs; [
        gimp
        deja-dup
      ];

      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      system.stateVersion = "25.05";

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
}
