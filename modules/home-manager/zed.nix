{ ... }:
{
  flake.modules.homeManager.zed =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        zed-editor
        nil
        pyright
        clang-tools
      ];

      programs.zed-editor = {
        enable = true;
        extensions = [
          "nix"
          "toml"
          "rust"
          "html"
          "c++"
          "python"
        ];
        userSettings = {
          hour_format = "hour24";
          vim_mode = false;
          "languages" = {
            "Nix" = {
              "language_servers" = [ "nil" ];
              "format_on_save" = "off";
            };
            "Python" = {
              "language_servers" = [ "pyright" ];
              "format_on_save" = "off";
            };
            "C" = {
              "language_servers" = [ "clangd" ];
              "format_on_save" = "off";
            };
            "C++" = {
              "language_servers" = [ "clangd" ];
              "format_on_save" = "off";
            };
          };
        };
      };
    };
}
