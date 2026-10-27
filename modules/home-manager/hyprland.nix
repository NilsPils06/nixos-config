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

      programs.rofi = {
        enable = true;
        settings = {
          modi = "window,drun,run";
          show-icons = true;
          display-window = "Windows";
          window-format = "{w} · {c} · {t}";
          kb-row-down = "Down,Control+n,Alt+Tab";
          kb-row-up = "Up,Control+p,Alt+ISO_Left_Tab";
          kb-accept-entry = "Return,KP_Enter";
        };
      };

      systemd.user.services.ambxst = {
        Unit = {
          Description = "Ambxst Desktop Shell";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${inputs.ambxst.packages.${pkgs.system}.default}/bin/ambxst";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };

      home.activation.ensureAmbxstConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD mkdir -p $HOME/.local/share/ambxst $HOME/.config/ambxst
        $DRY_RUN_CMD touch $HOME/.local/share/ambxst/hyprland.conf
        if [ -f "$HOME/.config/ambxst/binds.json" ]; then
          ${pkgs.jq}/bin/jq '.custom = []' "$HOME/.config/ambxst/binds.json" > "$HOME/.config/ambxst/binds.json.tmp" && mv "$HOME/.config/ambxst/binds.json.tmp" "$HOME/.config/ambxst/binds.json"
        fi
      '';

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "hyprlang";
        settings = {
          "$mod" = "SUPER";

          source = [
            "~/.local/share/ambxst/hyprland.conf"
          ];

          monitor = "eDP-1, 1920x1200@60, 0x0, 1";

          binds = {
            workspace_back_and_forth = true;
            allow_workspace_cycles = true;
          };

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
            "ALT, TAB, exec, rofi -show window"
            "ALT SHIFT, TAB, exec, rofi -show window"
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
