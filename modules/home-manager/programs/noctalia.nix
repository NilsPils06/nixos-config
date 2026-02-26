{
  pkgs,
  lib,
  config,
  options,
  noctalia,
  ...
}:
{
  options = {
    noctalia.enable = lib.mkEnableOption "Enable noctalia configuration";
  };

  config = lib.mkIf config.noctalia.enable {
  stylix.targets.noctalia-shell.enable = true;

    # configure options
    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
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
          avatarImage = "/home/drfoobar/.face";
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
      # this may also be a string or a path to a JSON file.
    };
  };
}
