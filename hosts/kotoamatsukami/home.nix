{ config, pkgs, ... }:

#let
#mars-mips-icon-file = pkgs.runCommand "mars-mips-icon-file" { } ''
#mkdir -p $out/
#cp ${./images/mars-mips.png} $out/mars-mips.png
#'';

#in
{
        # Home Manager needs a bit of information about you and the paths it should
        # manage.

        imports = [
                ../../modules/home-manager
        ];

        config = {
                # Enable shell configuration
                shell.enable = true;
                
                # Enable fastfetct configuration
                fastfetch.enable = true;
                
                # Enable gnome customization
                gnome-extensions.enable = true;
                gnome-theming.enable = true;

                # Enable Jetbrains IDE's
                jetbrains.enable = true;

                # Enable logisim and mars-mips
                csa-utils.enable = false;

                # Enable LaTeX
                latex.enable = false;
                fun-cli.enable = true;

                # Enable musescore
                composing.enable = false;
                discord.enable = true;
                gramps.enable = false;
                minecraft.enable = true;

                home.homeDirectory = "/home/nils";
                home.username = "nils";
                # This value determines the Home Manager release that your configuration is
                # compatible with.
                home.stateVersion = "25.05"; # Do not change unless you know what you are doing!
                home.packages = with pkgs; [
                        obs-studio # Record you screen
                        audacity # Audio recording and editing
                        shotcut # Video editing
                        # kdePackages.kwordquiz # Flash card builder

                        # Messaging apps
                        # signal-desktop
                        vesktop # A discord client
                ];

                xdg = {
                        enable = true;
                        desktopEntries = {
                                "cups" = {
                                        name = "Cups Printer Manager";
                                        noDisplay = true;
                                };
                                
                                "com.mitchellh.ghostty" = {
                                        name = "Ghostty";
                                        genericName = "Terminal Emulator";
                                        comment = "A terminal emulator";
                                        exec = "ghostty";
                                        icon = "terminal";
                                        categories = [ "System" "TerminalEmulator" ];
                                        startupNotify = true;
                                        terminal = false;
                                        actions = {
                                                new-window = {
                                                        name = "New Window";
                                                        exec = "ghostty";
                                                };
                                        };
                                };
                        };
                };

                # Ghostty terminal configuration
                programs.ghostty = {
                        enable = true;
                        enableBashIntegration = true;
                        installBatSyntax = true;
                        settings = {
                                theme = "Gruvbox Dark Hard";
                        };
                };

                # Let Home Manager install and manage itself.
                programs.home-manager.enable = true;
        };
}
