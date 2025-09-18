{ pkgs, lib, ...}: {
        imports = [
                ./systems/audio.nix
                ./systems/locale.nix
                ./systems/printing.nix
        ];
        audio.enable = lib.mkDefault true;
        locale.enable = lib.mkDefault true;
        printing.enable = lib.mkDefault true;
}
