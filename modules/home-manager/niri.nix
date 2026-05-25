{ inputs, ... }:
{
  flake.modules.homeManager.niri =
    { pkgs, ... }:
    let
      caelestia = "${inputs.niri-caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli}/bin/caelestia-shell";
    in
    {
      home.packages = with pkgs; [
        xwayland-satellite
        fuzzel
        brightnessctl
        wireplumber
        matugen
        awww
      ];

      programs.niri.settings = {
        layout = {
          gaps = 4;
        };

        binds = {
          "Mod+Tab".action.toggle-overview = [ ];
          "Mod+Return".action.spawn = [ "kitty" ];
          "Mod+D".action.spawn = [ "${caelestia}" "ipc" "call" "drawers" "toggle" "launcher" ];
          "Mod+S".action.spawn = [ "${caelestia}" "ipc" "call" "drawers" "toggle" "dashboard" ];
          "Mod+B".action.spawn = [ "firefox" ];
          "Mod+F".action.spawn = [ "thunar" ];
          "Mod+Q".action.close-window = [ ];
          "Mod+Shift+E".action.spawn = [ "${caelestia}" "ipc" "call" "drawers" "toggle" "session" ];
          "Mod+N".action.spawn = [ "${caelestia}" "ipc" "call" "drawers" "toggle" "sidebar" ];
          "Mod+Print".action.screenshot-screen = {
            show-pointer = false;
          };
          "Mod+Shift+S".action.screenshot-screen = {
            show-pointer = false;
          };
          "XF86AudioLowerVolume".action.spawn = [ "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
          "XF86AudioRaiseVolume".action.spawn = [ "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" ];
          "XF86AudioMute".action.spawn = [ "${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
          "XF86MonBrightnessUp".action.spawn = [ "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%+" ];
          "XF86MonBrightnessDown".action.spawn = [ "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%-" ];
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
          { command = [ "${pkgs.awww}/bin/awww-daemon" ]; }
          { command = [ "caelestia-shell" ]; }
          { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ]; }
        ];
      };
    };
}
