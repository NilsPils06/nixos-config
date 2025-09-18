{ lib, config, ...}: {
        options = {
                locale.enable = lib.mkEnableOption "enable locale.nix";
        };
        config = lib.mkIf config.locale.enable {
                time.timeZone = "Europe/Brussels";

                # Select internationalisation properties.
                i18n.defaultLocale = "en_IE.UTF-8";
                i18n.extraLocaleSettings = {
                        LC_ADDRESS = "en_IE.UTF-8";
                        LC_IDENTIFICATION = "en_IE.UTF-8";
                        LC_MEASUREMENT = "en_IE.UTF-8";
                        LC_MONETARY = "en_IE.UTF-8";
                        LC_NAME = "en_IE.UTF-8";
                        LC_NUMERIC = "en_IE.UTF-8";
                        LC_PAPER = "en_IE.UTF-8";
                        LC_TELEPHONE = "en_IE.UTF-8";
                        LC_TIME = "en_IE.UTF-8";
                };
                i18n.extraLocales = [ "en_GB.UTF-8/UTF-8" "nl_BE.UTF-8/UTF-8" ];
                services.xserver.xkb = {
                        layout = "us";
                        variant = "alt-intl";
                };        
        };
}
