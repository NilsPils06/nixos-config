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
        # rstudio
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
          "R"
        ];
        userSettings = {
          hour_format = "hour24";
          vim_mode = false;

          file_scan_exclusions = [
            # Algemeen / Git
            "**/.git"

            # Web / Node
            "**/node_modules"
            "**/.next"
            "**/dist"

            # Python
            "**/.venv"
            "**/venv"
            "**/env"
            "**/__pycache__"
            "**/.pytest_cache"
            "**/.mypy_cache"
            "**/.ruff_cache"
            "**/*.egg-info"

            # C/C++ en gecompileerde output
            "**/build"
            "**/out"
            "**/bin"
            "**/.cache"
          ];

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
