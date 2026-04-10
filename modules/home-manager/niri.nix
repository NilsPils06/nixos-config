{ ... }:
{
  flake.modules.homeManager.niri =
    { pkgs, ... }:
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
      home.packages = with pkgs; [
        xwayland-satellite
      ];

      programs.niri.settings = {
        layout = {
          gaps = 4;
        };

        binds = {
          "Mod+Tab".action.toggle-overview = [ ];
          "Mod+Return".action.spawn = "kitty";
          "Mod+D".action.spawn = noctalia "launcher toggle";
          "Mod+B".action.spawn = "firefox";
          "Mod+F".action.spawn = "thunar";
          "Mod+Q".action.close-window = [ ];
          "Mod+L".action.spawn = noctalia "lockScreen lock";
          "Mod+Print".action.screenshot-screen = {
            show-pointer = false;
          };
          "Mod+S".action.screenshot-screen = {
            show-pointer = false;
          };
          "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
          "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
          "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
          "Mod+WheelScrollDown".action.focus-workspace-down = [ ];
          "Mod+WheelScrollDown".cooldown-ms = 150;
          "Mod+WheelScrollUp".action.focus-workspace-up = [ ];
          "Mod+WheelScrollUp".cooldown-ms = 150;
          "Mod+Shift+WheelScrollUp".action.focus-column-left = [ ];
          "Mod+Shift+WheelScrollUp".cooldown-ms = 150;
          "Mod+Shift+WheelScrollDown".action.focus-column-right = [ ];
          "Mod+Shift+WheelScrollDown".cooldown-ms = 150;
          "Mod+Up".action.focus-workspace-up = [ ];
          "Mod+Down".action.focus-workspace-down = [ ];
          "Mod+Right".action.focus-column-right = [ ];
          "Mod+Left".action.focus-column-left = [ ];
          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+Minus".action.set-column-width = "-10%";
          "Mod+Equal".action.set-column-width = "+10%";
          "Mod+Shift+Minus".action.set-window-height = "-10%";
          "Mod+Shift+Equal".action.set-window-height = "+10%";
          "Mod+Shift+F".action.expand-column-to-available-width = [ ];
        };
        input = {
          keyboard.xkb.layout = "us";
          mouse.accel-profile = "flat";
          workspace-auto-back-and-forth = true;
        };
        outputs = {
          eDP-1.scale = 1.0;
        };
        spawn-at-startup = [
          { command = [ "noctalia-shell" ]; }
        ];
      };
    };
}
