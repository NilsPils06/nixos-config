{ pkgs, ... }:

{
  networking.hostName = "kotoamatsukami";

  imports = [
    ./../../modules/nixos
  ];

  services = {
    flatpak.enable = true;
    envfs.enable = true;
    fwupd.enable = true;
  };
  
  xdg.portal.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}