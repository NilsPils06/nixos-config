{ ... }:
{
  flake.modules.nixos.llm-agents =
    { pkgs, inputs, ... }:
    {
      environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
          antigravity-cli
        ];
    };
}
