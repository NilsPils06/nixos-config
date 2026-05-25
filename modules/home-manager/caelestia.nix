{ inputs, ... }:
{
  flake.modules.homeManager.caelestia =
    { pkgs, ... }:
    {
      home.packages = [
        inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli
        pkgs.kdePackages.qtwebengine
        pkgs.kdePackages.qtwebchannel
        pkgs.kdePackages.qtwebview
      ];

      # Configure Caelestia Shell fully declaratively
      xdg.configFile."caelestia-shell/shell.json".text = builtins.toJSON {
        appearance = {
          rounding = { scale = 1.0; };
          spacing = { scale = 1.0; };
          transparency = {
            enabled = true;
            reduceTransparency = false;
            base = 0.8;
          };
        };
        border = {
          thickness = 0;
          rounding = 10;
        };
        general = {
          isDistLogo = true;
          apps = {
            terminal = "kitty";
            browser = "firefox";
            explorer = "thunar";
          };
        };
        background = {
          enabled = true;
        };
        bar = {
          persistent = true;
          workspaces = {
            groupIconsByApp = true;
            doubleClickToCenter = true;
          };
          status = {
            showAudio = true;
            showWifi = true;
            showBattery = true;
            showClock = true;
          };
        };
        services = {
          useTwelveHourClock = false;
          useFahrenheit = false;
          smartScheme = true;
        };
      };
    };
}
