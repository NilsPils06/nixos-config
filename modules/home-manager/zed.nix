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
        rstudio
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

          show_edit_predictions = false; # Geen ghost-code meer
          features = {
            inline_completion_provider = "none";
          };

          assistant = {
            default_model = {
              provider = "ollama";
              model = "qwen2.5-coder:14b";
            };
            version = "2";
          };

          language_models = {
            ollama = {
              api_url = "http://localhost:11434";
              available_models = [
                {
                  name = "qwen2.5-coder:14b";
                  display_name = "Qwen 2.5 Coder (14B)";
                  max_tokens = 8192;
                }
                {
                  name = "codestral";
                  display_name = "Codestral (22B)";
                  max_tokens = 8192;
                }
              ];
            };
          };

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
