{ ... }:
{
  flake.modules.homeManager.noctalia = {
    stylix.targets.noctalia-shell.enable = true;

    programs.noctalia-shell = {
      enable = true;
      settings = {
        bar = {
          density = "compact";
          position = "right";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
            ];
            center = [
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            right = [
              {
                alwaysShowPercentage = false;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        general = {
          avatarImage = "/home/nils/.face";
          radiusRatio = 0.2;
        };
        location = {
          monthBeforeDay = false;
          name = "Brussels, Belgium";
        };
        notifications = {
          overlayLayer = false;
        };
        nightLight = {
          enabled = true;
          autoSchedule = true;
        };
      };
    };
  };
}
