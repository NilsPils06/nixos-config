{ pkgs, lib, ...}: {
        imports = [
                ./systems/locale.nix
        ];

        locale.enable = lib.mkDefault true;
}
