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
        };

        # Install firefox.
        programs.firefox.enable = true;

        # Allow unfree packages
        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
                # Command Line tools (CLI)
                bat # Better cat
                btop # Better top
                eza # Better ls
                fastfetch # CLI system info
                file # File information
                ghostty # Modern terminal emulator
                gh # Github CLI-client
                git # Version management
                libdvdcss # Decrypt DVDs
                nh # Nix helper
                trash-cli # rm on safe mode
                tree # Treevew of files
                tldr # When man is overkill
                xdg-utils # 
                unzip # Zip but the other way around
                wget # Getting things from the World Wide Web
                wl-clipboard # wl-copy my beloved
                zip # Unzip but the other way around
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
                python313 # A snake-based programming language
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
                # gramps
                libreoffice # Office Suite
                papers # Pdf reader, evince++
                pdfarranger # Basic pdf manipulation
                setzer # LaTeX, the editor
                texliveMedium # LaTeX, the language

                # Customization
                gnome-tweaks # Why isn't this in settings
                dconf-editor # I get why this isn't in settings

                # Extensions
                gnomeExtensions.alphabetical-app-grid # Back to GNOME 3.2x
                gnomeExtensions.appindicator # Yes, I know I shouldn't
                gnomeExtensions.caffeine # Stay awake, screen
                gnomeExtensions.hot-edge # When the top left is to far away
                gnomeExtensions.maximize-to-empty-workspace # MacOS did something right here
                gnomeExtensions.open-desktop-file-location # Great debugger
                gnomeExtensions.rounded-window-corners-reborn # Should be default
                gnomeExtensions.user-themes # Classic
                gnomeExtensions.vitals # System monitor in top bar

                # Back-ups
                deja-dup
        ];
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
        services.xserver.excludePackages = with pkgs; [
                xterm # Why is it here by default
        ];

        # Set nerd-fonts and ms-fonts
        fonts.packages = with pkgs; [
                # Microsoft fonts
                vista-fonts 
                corefonts
                # Nerd fonts
                nerd-fonts.jetbrains-mono
        ]; 
        # ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

        # `nh` module-based configuration for clean-up
        programs.nh = {
                enable = true;
                clean.enable = true;
                # Clean up old generations by keeping the last day and at least 3 generations.
                clean.extraArgs = "--keep-since 1d --keep 3";
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
