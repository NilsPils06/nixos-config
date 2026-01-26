{
  pkgs,
  lib,
  config,
  noctalia,
  ...
}:
{
  options = {
    noctalia.enable = lib.mkEnableOption "enable noctalia.nix";
  };
  config = lib.mkIf config.noctalia.enable {
    # install package
    environment.systemPackages = with pkgs; [
      noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      # ... maybe other stuff
    ];

  };
}
