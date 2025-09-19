{ lib, ...}: {
        imports = [
                ./cliApps/fastfetch.nix
                ./cliApps/shell.nix
        ];
}
