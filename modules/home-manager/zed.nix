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
              model = "qwen3.5:9b";
            };
            version = "2";
          };

          language_models = {
            ollama = {
              api_url = "http://localhost:11434";
              available_models = [
                {
                  name = "qwen3.5:9b";
                  display_name = "Qwen 3.5 (9B)";
                  max_tokens = 8192;
                }
                {
                  name = "gemma4:26b";
                  display_name = "Gemma 4 MoE (26B)";
                  max_tokens = 4096;
                }
                {
                  name = "gemma4:e4b";
                  display_name = "Gemma 4 Edge (4B)";
                  max_tokens = 2048;
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
