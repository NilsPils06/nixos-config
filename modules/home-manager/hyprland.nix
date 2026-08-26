{ inputs, ... }:
{
  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    {
      imports = [ inputs.caelestia-shell.homeManagerModules.default ];

      home.packages = with pkgs; [
        xwayland-satellite
        fuzzel
        brightnessctl
        wireplumber
        matugen
        awww
        kdePackages.qtwebengine
        kdePackages.qtwebchannel
        kdePackages.qtwebview
      ];

      programs.kitty.enable = true;

      programs.caelestia = {
        enable = true;
        cli.enable = true;
        systemd = {
          enable = true;
          target = "graphical-session.target";
        };
        settings = {
          border = {
            thickness = 0;
            rounding = 10;
          };
          general = {
            apps = {
              terminal = "kitty";
              explorer = "thunar";
            };
          };
          background.enabled = true;
          services = {
            useTwelveHourClock = false;
            useFahrenheit = false;
            smartScheme = true;
          };
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "hyprlang";
        settings = {
          "$mod" = "SUPER";

          input = {
            accel_profile = "flat";
            sensitivity = 0;
          };

          bind = [
            "$mod, Return, exec, kitty"
            "$mod, Q, killactive,"
            "$mod SHIFT, F, fullscreen,"
            "$mod, D, exec, caelestia shell drawers toggle launcher"
            "$mod, S, exec, caelestia shell drawers toggle dashboard"
            "$mod, B, exec, firefox"
            "$mod, F, exec, thunar"
            "$mod, X, togglefloating, active"
            "$mod SHIFT, E, exec, caelestia shell drawers toggle session"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            "$mod, Right, workspace, +1"
            "$mod, Left, workspace, -1"
            "$mod, TAB, cyclenext,"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (
              builtins.genList (
                i:
                let
                  ws = i + 1;
                in
                [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              ) 9
            )
          );

          binde = [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
            ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ];
        };
      };

      home.sessionVariables.NIXOS_OZONE_WL = "1";
    };
}
