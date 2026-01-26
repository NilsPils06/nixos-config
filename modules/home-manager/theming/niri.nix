{
  pkgs,
  lib,
  config,
  options,
  niri,
  ...
}:
{
  options = {
    niri-config.enable = lib.mkEnableOption "Enable niri-config configuration";
  };

  config = lib.mkIf config.niri-config.enable {
    home.packages = with pkgs; [
      fuzzel
    ];
    # imports = [ niri.homeModules.niri ];

    nixpkgs.overlays = [ niri.overlays.niri ];
    programs.niri.settings = {
      # Basic keybindings
      binds = {
        "Mod+Return".action.spawn = "kitty";
        "Mod+D".action.spawn = "fuzzel";
        "Mod+Q".action.close-window = [ ];
      };
      input = {
      	keyboard.xkb.layout = "us";
};

      # Startup applications
      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
        { command = [ "fuzzel" ]; }
      ];
    };
  };
}
