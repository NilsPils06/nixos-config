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

    # Privacy settings
    "org/gnome/desktop/privacy" = {
    	recent-files-max-age = 30;
    	old-files-age = 30;
    	remove-old-temp-files = true;
    	remove-old-trash-files = true;
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
	autostart = {
		enable = true;
		entries = [ "${config.home.homeDirectory}/.nix-profile/share/applications/vesktop.desktop" ];
	};
	desktopEntries = {
		"cups" = {
			name = "Cups Printer Manager";
			noDisplay = true;
		};
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
		"muse-sounds-manager" = {
			name = "Muse Sounds Manager";
			icon = "enjoy-music-player";
			comment = "Manage Muse sound themes";
			exec = "muse-sounds-manager";
			categories = [ "Audio" ];
		};
	};
  };
  
  # Shell configuration
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

  # Fastfetch configuration
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        type = "small";
        color = {
          "1" = "#5277C3";
          "2" = "#7EBAE4";
        };
      };
      display = {
        separator = " · ";
        color = "bright_blue";
      };
    modules = [
        {
          type = "custom";
          format = "┌─────────── Hardware Information ───────────┐";
        }
        {
          type = "host";
          key = "  󰌢";
        }
        {
          type = "cpu";
          key = "  ";
        }
        {
          type = "gpu";
          detectionMethod = "pci";
          key = "  ";
        }
        {
          type = "display";
          key = "  󱄄";
        }
        {
          type = "memory";
          key = "  ";
        }
        {
          type = "custom";
          format = "├─────────── Software Information ───────────┤";
        }
        {
          type = "os";
          key = "  ";
        }
        {
          type = "kernel";
          key = "  ";
          format = "{1} {2}";
        }
        {
          type = "wm";
          key = "  ";
        }
        {
          type = "shell";
          key = "  ";
        }
        {
          type = "custom";
          format = "|───────────── Uptime / Age ─────────────────|";
        }
        {
          type = "command";
          key = "  OS Age ";
          keyColor = "magenta";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          type = "uptime";
          key = "  Uptime ";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };
  
  # Git configuration
  programs.git = {
    enable = true;
    userName = "Mathijs";
    userEmail = "79464596+CouldBeMathijs@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Ghostty terminal configuration
  programs.ghostty = {
  	enable = true;
  	enableBashIntegration = true;
  	installBatSyntax = true;
  	settings = {
  	  theme = "Darkside";
  	};
  };

  programs.zoxide = {
  	enable = true;
  	enableBashIntegration = true;
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
