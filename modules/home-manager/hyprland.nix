{ inputs, ... }:
{
  flake.modules.homeManager.hyprland =
    { pkgs, lib, ... }:
    {
      home.packages = with pkgs; [
        inputs.ambxst.packages.${pkgs.system}.default
        xwayland-satellite
        fuzzel
        brightnessctl
        wireplumber
        matugen
        awww
      ];

      programs.kitty.enable = true;

      home.activation.ensureAmbxstHyprlandConf = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD mkdir -p $HOME/.local/share/ambxst
        $DRY_RUN_CMD touch $HOME/.local/share/ambxst/hyprland.conf
      '';

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "hyprlang";
        settings = {
          "$mod" = "SUPER";

          exec-once = [
            "ambxst"
          ];

          source = [
            "~/.local/share/ambxst/hyprland.conf"
          ];

          monitor = "eDP-1, 1920x1200@60, 0x0, 1";

          input = {
            accel_profile = "flat";
            sensitivity = 0;
            touchpad = {
                  natural_scroll = true;
                  disable_while_typing = false;
            };
          };

          bind = [
            "$mod, Return, exec, kitty"
            "$mod, Q, killactive,"
            "$mod SHIFT, F, fullscreen,"
            "$mod, D, exec, ambxst run launcher"
            "$mod, S, exec, ambxst run dashboard"
            "$mod, B, exec, firefox"
            "$mod, F, exec, thunar"
            "$mod, X, togglefloating, active"
            "$mod SHIFT, E, exec, ambxst run powermenu"
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
