{ lib, ...}: {
        imports = [
                ./DE-WM/cinnamon.nix
                ./DE-WM/gnome.nix
                ./DE-WM/kde.nix
                
                ./programs/cli-utils.nix
                ./programs/fonts.nix
                ./programs/gaming.nix
                ./programs/gnome-apps.nix

                ./systems/audio.nix
                ./systems/locale.nix
                ./systems/nh.nix
                ./systems/plymouth.nix
        ];
        cli-utils.enable = lib.mkDefault true;
        fonts.enable = lib.mkDefault true;

        audio.enable = lib.mkDefault true;
        locale.enable = lib.mkDefault true;
        nh.enable = lib.mkDefault true;
        plymouth.enable = lib.mkDefault true;
}
