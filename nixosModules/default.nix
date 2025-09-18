{ pkgs, lib, ...}: {
        imports = [
                ./programs/fonts.nix


                ./systems/audio.nix
                ./systems/locale.nix
                ./systems/nh.nix
                ./systems/printing.nix
        ];
        fonts.enable = lib.mkDefault true;

        audio.enable = lib.mkDefault true;
        locale.enable = lib.mkDefault true;
        nh.enable = lib.mkDefault true;
        printing.enable = lib.mkDefault true;
}
