{ pkgs-unstable, gruvboxPlusIcons, lib, config, options, ... }:
{
        options = {
                gnome-theming.enable = lib.mkEnableOption "enable gnome-theming";
        };

        config = lib.mkIf config.gnome-theming.enable {

                dconf.enable = true;
                dconf.settings = {    
                        # Configure enabled GNOME Shell extensions via their UUIDs.
                        # Command: 
                        # cat $(nix eval --raw nixpkgs#gnomeExtensions.EXTENSION)/share/gnome-shell/extensions/*/metadata.json


                        # Change button layout
                        "org/gnome/desktop/wm/preferences" = {
                                button-layout = "close,minimize,maximize:appmenu";
                        };

                        # Privacy settings
                        "org/gnome/desktop/privacy" = {
                                recent-files-max-age = 30;
                                old-files-age = 30;
                                remove-old-temp-files = true;
                                remove-old-trash-files = true;
                        };

                        # Font settings
                        "org/gnome/desktop/interface" = {
                                document-font-name = "JetBrainsMono Nerd Font 11";
                                font-name = "JetBrainsMono Nerd Font 11";
                                monospace-font-name = "JetBrainsMono Nerd Font 11";
                        };

                        # Fractional scaling
                        "org/gnome/mutter" = {
                                experimental-features = [ "scale-monitor-framebuffer" ];
                        };
                };

                # The `gtk` module manages GTK themes and icons for your user environment
                # and sets up necessary configuration files.
                gtk = {
                        enable = true;
                        theme = {
                                name = "Gruvbox-Dark";
                                package = pkgs-unstable.gruvbox-gtk-theme.override {
                                        tweakVariants = [ "macos" ];
                                };
                        };
                        iconTheme = {
                                name = "Gruvbox-Plus-Dark";
                                package = gruvboxPlusIcons;
                        };
                        gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
                        gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
                };
                programs.gnome-shell.theme = {
                        name = "Gruvbox-Dark";
                        package = pkgs-unstable.gruvbox-gtk-theme.override {
                                tweakVariants = [ "macos" ];
                        };
                };
                xdg.configFile = {
                                "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
                                "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
                                "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
                        };
        };
}
