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

  home.packages = [
	#I prefer system-wide packages
  ];

  # The correct way to enable the dconf service.
  dconf.enable = true;
  dconf.settings = {    
    # Configure enabled GNOME Shell extensions via their UUIDs.
    # Command: 
    # cat $(nix eval --raw nixpkgs#gnomeExtensions.EXTENSION)/share/gnome-shell/extensions/*/metadata.json
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "AlphabeticalAppGrid@stuarthayhurst"
		"appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "hotedge@jonathan.jdoda.ca"
		"rounded-window-corners@fxgn"
        "MaximizeToEmptyWorkspace-extension@kaisersite.de"
        "open-desktop-location@laura.media"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
      ];
      disable-extension-version-validation = true;
    };
    
	# Extensions settings
    "org/gnome/shell/extensions/hot-edge" = {
      enable-hot-edge = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      override-background-dynamically = true;
    };

    "org/gnome/shell/extensions/vitals" = {
    	icon-style = 1; # GNOME-style icons
    	position-in-panel = 2; # Right, left of system menu	
    };
    
	# Change button layout
    "org/gnome/desktop/wm/preferences" = {
    	button-layout = "close,minimize,maximize:appmenu";
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
  programs.gnome-shell.theme.name = "Adwaita";

  xdg = {
	enable = true;
	desktopEntries = {
		"mars" = {
		    name = "Mars MIPS";
			categories = [ "Development" "IDE" ];
			comment = "IDE for programming in MIPS assembly language intended for educational-level use";
		    genericName = "MIPS Editor";
		    exec = "Mars";
		    type = "Application";
		    icon = "${mars-mips-icon-file}/mars-mips.png";
		};
		"vesktop" = {
			name = "Vesktop";
			comment = "A Discord client";
			genericName = "Discord Client";
			exec = "vesktop";
			type = "Application";
			icon = "discord";
		};
	};
  };
  
  # Your shell configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      "z" = "zoxide";
      "cat" = "bat";
      "ls" = "eza";
      "ll" = "eza -l";
      ".." = "cd ..";
      "switch-home" = "nh home switch ${flake} && nh clean user --keep-since 3d --keep 5";
      "flake-update" = "nix flake update --flake ${flake}";
	  "switch-all" = "nh os switch ${flake} && nh home switch ${flake} && nh clean user --keep-since 3d --keep 5";
	  "topgrade" = "nix flake update --flake ${flake} && nh os switch ${flake} && nh home switch ${flake} && nh clean user --keep-since 3d --keep 5";
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
