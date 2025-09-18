# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, pkgs-unstable, ... }:

{
        networking.hostName = "athena"; # Define your hostname
        # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

        # Configure network proxy if necessary
        # networking.proxy.default = "http://user:password@proxy:port/";
        # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
        gnome.enable = true;

         # Allow unfree packages
        nixpkgs.config.allowUnfree = true;

        # Enable networking
        networking.networkmanager.enable = true;

        imports = [
                ./../../nixosModules
        ];
        services = {
                envfs.enable = true;
                fwupd.enable = true;
        };
        security.rtkit.enable = true;

        # Define a user account. Don't forget to set a password with ‘passwd’.
        users.users.mathijs = {
                isNormalUser = true;
                description = "Mathijs Pittoors";
                extraGroups = [ "networkmanager" "wheel" ];
        };

        # Install firefox.
        programs.firefox.enable = true;

        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
                # Command Line tools (CLI)
                bat # Better cat
                eza # Better ls
                fastfetch # CLI system info
                gh # Github CLI-client
                libdvdcss # Decrypt DVDs
                trash-cli # rm on safe mode
                tldr # When man is overkill
                zoxide # cd^2

                # Communication
                fractal # Matrix client
                signal-desktop # Signal messenger
                vesktop # Discord client

                # Development
                cmake # make++
                devtoolbox # Some things
                pkgs-unstable.jetbrains.clion # A working C/C++ IDE as long as I'm a student
                pkgs-unstable.jetbrains.pycharm-professional # Python IDE
                gcc # GNU C Compiler
                logisim # Live laugh Logisim - Swiepie (2024)
                mars-mips # MIPS Assembly IDE
                ninja # another compilation thingie
                python3 # A snake-based programming language
                valgrind # Squash those memory leaks

                # Media
                amberol # Music player
                clapper # Video player
                gimp # GNU Image Manipulation Program
                handbrake # Transcode away
                impression # dd + GUI
                makemkv # Rip bluerays and DVDs
                musescore # Writing music scores
                muse-sounds-manager # Write music scores with better playback
                parabolic # Less sketchy YouTube downloader
                pitivi # Basic video editor

                # Documents
                # gramps # Geneology
                libreoffice # Office Suite
                papers # Pdf reader, evince++
                pdfarranger # Basic pdf manipulation
                rnote # Handdrawn note taking
                setzer # LaTeX, the editor
                texliveMedium # LaTeX, the language

                # Back-ups
                deja-dup 

                # Games
                quadrapassel # Tetris in all but name
                gnome-nibbles # Snake++
        ];

        boot = {
                kernelPackages = pkgs.linuxPackages_zen;
                plymouth = {
                        enable = true;
                        theme = "rings";
                        themePackages = with pkgs; [
                                # By default we would install all themes
                                (adi1090x-plymouth-themes.override {
                                        selected_themes = [ "rings" ];
                                })
                        ];
                };
                # Enable "Silent boot"
                consoleLogLevel = 3;
                initrd.verbose = false;
                kernelParams = [
                        "quiet"
                        "splash"
                        "boot.shell_on_fail"
                        "udev.log_priority=3"
                        "rd.systemd.show_status=auto"
                ];
               loader = {
                        systemd-boot.enable = true;
                        efi.canTouchEfiVariables = true;
                        # Hide the OS choice for bootloaders.
                        # It's still possible to open the bootloader list by pressing any key
                        # It will just not appear on screen unless a key is pressed
                        timeout = 0;
                };

        };

        # Do not change me unless you know what you are doing!! Check documentation first!!
        system.stateVersion = "25.05"; # Did you read the comment?

        # Enable Flakes
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
