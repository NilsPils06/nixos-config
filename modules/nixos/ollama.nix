{ ... }:
{
  flake.modules.nixos.ollama =
    { pkgs, ... }:
    {
      services.ollama = {
        enable = true;

        package = pkgs.ollama-rocm;
        environmentVariables = {
          HSA_OVERRIDE_GFX_VERSION = "11.0.0";
        };

        loadModels = [
          "qwen3.5:9b"
          "qwen2.5-coder:7b"
          "gemma4:26b"
          "gemma4:e4b"
        ];
      };

      environment.systemPackages = with pkgs; [
        ollama-rocm
      ];

      users.users.nils.extraGroups = [
        "video"
        "render"
      ];
    };
}
