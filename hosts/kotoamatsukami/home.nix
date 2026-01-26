{ config, pkgs, ... }:

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
    gnome-stylix.enable = true;
    stylix.enable = true;
    
    niri-config.enable = true;
    noctalia.enable = true;

    # Enable Jetbrains IDE's
    jetbrains.enable = true;

    discord.enable = true;
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
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
