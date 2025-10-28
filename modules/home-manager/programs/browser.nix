{ pkgs, lib, config, options, zen-browser, ... }:
{
        options = {
                browser.enable = lib.mkEnableOption "Enable zen-browser configuration";
        };

        config = lib.mkIf config.browser.enable {
                home.packages = [ 
                        pkgs.firefox
                ];
                xdg = {
                        enable = true;
                        desktopEntries = {
                                "zen-beta" = {
                                        name = "Zen Browser";
                                        genericName = "Web Browser";
                                        comment = "A web browser based on Zen";
                                        exec = "zen-beta %U";
                                        icon = "zen-browser";
                                        terminal = false;
                                        type = "Application";
                                        mimeType = [
                                                "text/html"
                                                "text/xml"
                                                "application/xhtml+xml"
                                                "application/vnd.mozilla.xul+xml"
                                                "x-scheme-handler/http"
                                                "x-scheme-handler/https"
                                        ];
                                        categories = [
                                                "Network"
                                                "WebBrowser"
                                        ];
                                        startupNotify = true;
                                };
                        };
                };
        };

}
