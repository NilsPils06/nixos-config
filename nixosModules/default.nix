{ lib, ...}: {
        imports = [
                ./DE-WM/gnome.nix
                
                ./programs/cli-utils.nix
                ./programs/fonts.nix
                ./programs/gnome-apps.nix

                ./systems/audio.nix
                ./systems/locale.nix
                ./systems/nh.nix
                ./systems/plymouth.nix
                ./systems/printing.nix
        ];
        cli-utils.enable = lib.mkDefault true;
        fonts.enable = lib.mkDefault true;

        audio.enable = lib.mkDefault true;
        locale.enable = lib.mkDefault true;
        nh.enable = lib.mkDefault true;
        printing.enable = lib.mkDefault true;
        plymouth.enable = lib.mkDefault true;
}
