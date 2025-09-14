# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ asus-numberpad-driver, inputs, config, pkgs, ... }:

{
        # imports =
        #        [ # Include the results of the hardware scan.map
        #                ./hardware-configuration # and in the NixOS manual (accessible by running ‘nixos-help’).map
        #        ];
        # Bootloader
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "athena"; # Define your hostname
        # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

        # Configure network proxy if necessary
        # networking.proxy.default = "http://user:password@proxy:port/";
        # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

        # Enable networking
        networking.networkmanager.enable = true;

        # Set your time zone.
        time.timeZone = "Europe/Brussels";

        # Select internationalisation properties.
        i18n.defaultLocale = "en_IE.UTF-8";
        i18n.extraLocaleSettings = {
                LC_ADDRESS = "en_IE.UTF-8";
                LC_IDENTIFICATION = "en_IE.UTF-8";
                LC_MEASUREMENT = "en_IE.UTF-8";
                LC_MONETARY = "en_IE.UTF-8";
                LC_NAME = "en_IE.UTF-8";
                LC_NUMERIC = "en_IE.UTF-8";
                LC_PAPER = "en_IE.UTF-8";
                LC_TELEPHONE = "en_IE.UTF-8";
                LC_TIME = "en_IE.UTF-8";
        };
        i18n.extraLocales = [ "en_GB.UTF-8/UTF-8" "nl_BE.UTF-8/UTF-8" ];
        services = {
                avahi = {
                        enable = true;
                        nssmdns4 = true;
                        openFirewall = true;
                };
                xserver ={
                        enable = true;
                        # Enable GNOME
                        displayManager.gdm.enable = true;
                        desktopManager.gnome.enable = true;
                        # Set keyboard layout
                        xkb = {
                                layout = "us";
                                variant = "alt-intl";
                        };
                };
                printing = {
                        enable = true;
                        drivers = [ pkgs.epson-escpr pkgs.epson-escpr2 pkgs.epson_201207w ];
                };
                pulseaudio.enable = false;
                pipewire = {
                        enable = true;
                        alsa.enable = true;
                        alsa.support32Bit = true;
                        pulse.enable = true;
                };
                envfs.enable = true;
                asus-numberpad-driver = {
                        enable = true;
                        layout = "up5401ea";
                        wayland = true;
                        runtimeDir = "/run/user/1000/";
                        waylandDisplay = "wayland-0";
                        ignoreWaylandDisplayEnv = false;
                        config = {
                                # e.g. "activation_time" = "0.5";
                                # More Configuration Options
                        };
                };
                fwupd.enable = true;
        };
        security.rtkit.enable = true;

        # Extra printer stuff
        hardware.sane = {
                enable = true;
                extraBackends = [ pkgs.utsushi pkgs.sane-airscan ];
                disabledDefaultBackends = [ "escl" ];
        };
        services.udev.packages = [ pkgs.utsushi pkgs.sane-airscan ];


        # Configure console keymap
        console.keyMap = "us";

        # Define a user account. Don't forget to set a password with ‘passwd’.
        users.users.mathijs = {
                isNormalUser = true;
                description = "Mathijs Pittoors";
                extraGroups = [ "networkmanager" "wheel" ];
                packages = with pkgs; [];
        };

        # Install firefox.
        programs.firefox.enable = true;

        # Allow unfree packages
        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
                # Command Line tools (CLI)
                bat
                btop
                eza
                fastfetch
                file
                ghostty
                gh
                git
                libdvdcss
                micro-with-wl-clipboard
                nh
                trash-cli
                tree
                tldr
                xdg-utils
                unzip
                wget
                wl-clipboard
                zip
                zoxide

                # Communication
                fractal
                signal-desktop
                vesktop

                # Development
                bottles
                cmake
                devtoolbox
                jetbrains.clion
                jetbrains.pycharm-professional
                gcc
                logisim
                mars-mips
                ninja
                python313
                valgrind
                whatip

                # Media
                amberol
                celluloid
                drawing
                gimp
                handbrake
                impression
                makemkv
                musescore
                muse-sounds-manager
                parabolic
                pitivi

                # Documents
                epsonscan2
                # gramps
                libreoffice
                papers
                pdfarranger
                setzer
                texliveMedium

                # Customization
                gnome-tweaks
                dconf-editor
                home-manager

                # Themes
                adw-gtk3
                kora-icon-theme

                # Extensions
                gnomeExtensions.alphabetical-app-grid
                gnomeExtensions.appindicator
                gnomeExtensions.blur-my-shell
                gnomeExtensions.caffeine
                gnomeExtensions.hot-edge
                gnomeExtensions.maximize-to-empty-workspace
                gnomeExtensions.open-desktop-file-location
                gnomeExtensions.rounded-window-corners-reborn
                gnomeExtensions.user-themes
                gnomeExtensions.vitals

                # Back-ups
                deja-dup
        ];

        # Disable some applications
        environment.gnome.excludePackages = (with pkgs; [
                evince
                geary # email reader
                gnome-characters
                gnome-console
                gnome-music
                gnome-tour
                totem # video player
                yelp
        ]);
        services.xserver.excludePackages = with pkgs; [
                xterm
        ];

        # Set nerd-fonts and ms-fonts
        fonts.packages = with pkgs; [ 
                vista-fonts 
                corefonts
        ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

        # `nh` module-based configuration for clean-up
        programs.nh = {
                enable = true;
                clean.enable = true;
                # Clean up old generations by keeping the last 7 days and at least 3 generations.
                clean.extraArgs = "--keep-since 7d --keep 3";
                flake = "/home/mathijs/.dotfiles"; 
        };

        xdg.portal = {
                enable = true;
                wlr.enable = true;
                extraPortals = with pkgs; [
                        xdg-desktop-portal
                        xdg-desktop-portal-gtk
                ];
        };

        # Enable plymouth
        boot = {
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
                # Hide the OS choice for bootloaders.
                # It's still possible to open the bootloader list by pressing any key
                # It will just not appear on screen unless a key is pressed
                loader.timeout = 0;
        };

        # Do not change me unless you know what you are doing!! Check documentation first!!
        system.stateVersion = "25.05"; # Did you read the comment?

        # Enable Flakes
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
