{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    gnome-apps.enable = lib.mkEnableOption "enable gnome-apps.nix";
  };
  config = lib.mkIf config.gnome-apps.enable {
    environment.systemPackages = with pkgs; [
      devtoolbox # Just some nicities
      impression # dd but Gnome
      parabolic # Media downloader
      papers # Pdf reader
      pitivi # Video editor
      gtranslator # PO translation editor
    ];
    environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
      lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
        [
          pkgs.gst_all_1.gst-plugins-good
          pkgs.gst_all_1.gst-plugins-bad
          pkgs.gst_all_1.gst-plugins-ugly
        ];
  };
}
