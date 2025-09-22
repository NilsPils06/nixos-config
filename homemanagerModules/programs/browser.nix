{ pkgs, lib, config, options, zen-browser, ... }:
{
        options = {
                browser.enable = lib.mkEnableOption "Enable zen-browser configuration";
        };

        config = lib.mkIf config.minecraft.enable {
                home.packages = with zen-browser.packages."x86_64-linux"; [ beta ];
                #programs.zen-browser.enable = true;
        };

}
