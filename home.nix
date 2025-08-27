{ config, pkgs, ... }:

let
  mars-mips-icon-file = pkgs.runCommand "mars-mips-icon-file" { } ''
    mkdir -p $out/
    cp ${./images/mars-mips.png} $out/mars-mips.png
  '';
  
  flake = "${config.home.homeDirectory}/.dotfiles";

in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mathijs";
  home.homeDirectory = "/home/mathijs";

  # This value determines the Home Manager release that your configuration is
  # compatible with.
  home.stateVersion = "25.05"; # Do not change unless you know what you are doing!

  # This is where we install all the necessary packages.
  # The `mars-mips` package is now included here.
  home.packages = [
    # Themes
    pkgs.adw-gtk3
    pkgs.kora-icon-theme

    # Extensions
    pkgs.gnomeExtensions.alphabetical-app-grid
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.hot-edge
    pkgs.gnomeExtensions.maximize-to-empty-workspace
    pkgs.gnomeExtensions.user-themes

    pkgs.mars-mips
    
    # Add jq for parsing JSON
    pkgs.jq
  ];

  # The correct way to enable the dconf service.
  dconf.enable = true;
  dconf.settings = {    
    # Configure enabled GNOME Shell extensions via their UUIDs.
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "AlphabeticalAppGrid@stuarthayhurst"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "hotedge@jonathan.jdoda.ca"
        "MaximizeToEmptyWorkspace-extension@kaisersite.de"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
    
	# Extensions settings
    "org/gnome/shell/extensions/hot-edge" = {
      enable-hot-edge = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      override-background-dynamically = true;
    };
  };

  # The `gtk` module manages GTK themes and icons for your user environment
  # and sets up necessary configuration files.
  gtk = {
    enable = true;
    theme = {
      name = "Adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
  };
  
  # The XDG desktop entry for your Mars MIPS application.
  # The icon path now correctly points to the file in the Nix store.
  xdg.desktopEntries."mars-mips" = {
    name = "Mars MIPS";
    genericName = "MIPS Editor";
    exec = "mars-mips";
    type = "Application";
    icon = "${mars-mips-icon-file}/mars-mips.png";
  };

  # Your shell configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      "switch-nix" = "nh os switch ${flake}";
      "switch-home" = "nh home switch ${flake}";
      "flake-update" = "nix flake update --flake ${flake}";
      "topgrade" = "nix flake update --flake ${flake} && nh os switch ${flake} && nh home switch ${flake} && nh clean --home --keep-since 7d --keep 3";
      "switch-all" = "nh os switch ${flake} && nh home switch ${flake} && nh clean --home --keep-since 7d --keep 3";
    };
  };

    # Your git configuration
  programs.git = {
    enable = true;
    userName = "Mathijs";
    userEmail = "79464596+CouldBeMathijs@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
