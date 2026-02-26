{ pkgs, lib, ... }:

{
  niri.enable = lib.mkDefault true;
  noctalia.enable = lib.mkDefault true;
  locale.language = lib.mkDefault "irish";

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

  networking.networkmanager.enable = true;
  security.rtkit.enable = true;

  users.users.nils = {
    isNormalUser = true;
    description = "Nils Van de Velde";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
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
}