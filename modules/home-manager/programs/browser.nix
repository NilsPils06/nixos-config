{ pkgs, lib, config, options, ... }:
{
        options = {
                browser.enable = lib.mkEnableOption "Enable firefox configuration";
        };

        config = lib.mkIf config.browser.enable {
                home.packages = [ 
                        pkgs.firefox
                ];
        };

}
