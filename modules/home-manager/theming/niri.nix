{
  pkgs,
  lib,
  config,
  options,
  niri,
  ...
}:
let
  noctalia =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  options = {
    niri-config.enable = lib.mkEnableOption "Enable niri-config configuration";
  };

  config = lib.mkIf config.niri-config.enable {
  
    home.packages = with pkgs; [
	xwayland-satellite
    ];
    # imports = [ niri.homeModules.niri ];

    nixpkgs.overlays = [ niri.overlays.niri ];
    programs.niri.settings = {
      # Basic keybindings
      binds = {
	"Mod+Tab".action.toggle-overview = [];
        "Mod+Return".action.spawn = "kitty";
        "Mod+D".action.spawn = noctalia "launcher toggle";
	"Mod+B".action.spawn = "firefox";
        "Mod+Q".action.close-window = [ ];
        "Mod+L".action.spawn = noctalia "lockScreen lock";
        "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
        "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
        "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
        "Mod+WheelScrollDown".action.focus-workspace-down = [];
        "Mod+WheelScrollDown".cooldown-ms = 150;
        "Mod+WheelScrollUp".action.focus-workspace-up = [];
        "Mod+WheelScrollUp".cooldown-ms = 150;
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [];
        "Mod+Shift+WheelScrollUp".cooldown-ms = 150;
        "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
        "Mod+Shift+WheelScrollDown".cooldown-ms = 150;
        "Mod+Up".action.focus-workspace-up = [];
        "Mod+Down".action.focus-workspace-down = [];
        "Mod+Right".action.focus-column-right = [];
        "Mod+Left".action.focus-column-left = [];
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
      };
      input = {
        keyboard.xkb.layout = "us";
	mouse.accel-profile = "flat";
	workspace-auto-back-and-forth = true;
      };

      # Startup applications
      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
      ];
    };
  };
}
