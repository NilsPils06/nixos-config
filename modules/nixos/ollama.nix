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
          "qwen3.5:35b-a3b-moe"
          "codestral"
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
