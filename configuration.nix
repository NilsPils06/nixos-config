# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "athena"; # Define your hostname.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "alt-intl";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mathijs = {
    isNormalUser = true;
    description = "Mathijs Pittoors";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #Command Line tools
    fastfetch
    git
    libdvdcss
    micro-with-wl-clipboard
    nh
    trash-cli
    tldr
    wget

    #Communication
    fractal
    signal-desktop
    vesktop

    #Development
    devtoolbox
    jetbrains.clion
    jetbrains.pycharm-professional
    logisim
    whatip

    #Media
    amberol
    drawing
    gimp
    gramps
    handbrake
    impression
    makemkv
    pitivi

    #Documents
    epsonscan2
    libreoffice
    setzer

    #Customization
    gnome-tweaks
    dconf-editor

    # Extensions
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.blur-my-shell
   	gnomeExtensions.caffeine
    gnomeExtensions.hot-edge
    gnomeExtensions.maximize-to-empty-workspace
	gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.user-themes
	
    #Back-ups
    deja-dup
  ];

  # New `nh` module-based configuration for clean-up
  programs.nh = {
    enable = true;
    clean.enable = true;
    # Clean up old generations by keeping the last 7 days and at least 3 generations.
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/home/mathijs/.dotfiles"; 
  };
  
  # Do not change me unless you know what you are doing!! Check documentation first!!
  system.stateVersion = "25.05"; # Did you read the comment?

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
