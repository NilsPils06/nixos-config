{ pkgs, lib, config, ...}: {
        options = {
                gnome.enable = lib.mkEnableOption "enable gnome.nix";
        };
        config = lib.mkIf config.gnome.enable {
                services.xserver ={
                        enable = true;
                        # Enable GNOME
                        displayManager.gdm.enable = true;
                        desktopManager.gnome.enable = true;
                        excludePackages = with pkgs; [
                                xterm # Why is it here by default
                        ];

                };
                # Disable some applications
                environment.gnome.excludePackages = (with pkgs; [
                        decibels # Default audio player
                        evince # Default deprecated document viewer (superceded by papers)
                        epiphany # Default web browser
                        geary # Default mail client
                        gnome-characters # Unicode character list
                        gnome-connections # Remote desktop client
                        gnome-console # Default terminal client
                        gnome-music # Default music player
                        gnome-tour # System tour
                        nixos-render-docs # Nixos docs
                        totem # Default deprecated video player
                        yelp # Gnome help and docs
                ]);
                xdg.portal = {
                        enable = true;
                        wlr.enable = true;
                        extraPortals = with pkgs; [
                                xdg-desktop-portal
                                xdg-desktop-portal-gtk
                        ];
                };

                environment.systemPackages = with pkgs; [
                        # Gnome customization applications
                        dconf-editor # I get why this isn't in gnome-settings
                        gnome-tweaks # But this should be
                ] ++ (with pkgs.gnomeExtensions; [
                                # Gnome Extensions
                                alphabetical-app-grid # Back to GNOME 3.2x
                                appindicator # Yes, I know I shouldn't
                                caffeine # Stay awake, screen
                                hot-edge # When the top left is to far away
                                maximize-to-empty-workspace # MacOS did something right here
                                open-desktop-file-location # Great debugging help
                                rounded-window-corners-reborn # Should be default
                                user-themes # Classic
                                vitals # System monitor in top bar
                                paperwm # Scrolling window management
                        ]);

        };
}
