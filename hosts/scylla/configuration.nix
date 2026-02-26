{ pkgs, ... }:

{
  networking.hostName = "scylla";
  
  imports = [
    ./../../modules/nixos
  ];

  services = {
    envfs.enable = true;
    fwupd.enable = true;
    upower.enable = true;
    postgresql = {
      enable = true;
      ensureDatabases = [ "mydatabase" ];
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all      all     trust
        host  all      all     127.0.0.1/32   trust
        host  all      all     ::1/128        trust
      '';
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
        CREATE DATABASE nixcloud;
        GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
      '';
    };
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "nils" ];
}