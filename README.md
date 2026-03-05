# My NixOS-config

Originally based on [CouldBeMathijs/nixos-config](https://github.com/CouldBeMathijs/nixos-config)

Structured using the **Dendritic Nix pattern** with [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree).

Expects to be put in ~/.dotfiles

Do not forget to bring your own hardware-configuration.nix!

## Structure

```
flake.nix                           # Minimal — just inputs + import-tree
modules/
  flake/
    flake.nix                       # Flake-parts setup (flakeModules imports)
    lib.nix                         # mkNixosHost helper
    systems.nix                     # perSystem configuration (pkgs, formatter)
  hosts/
    scylla/                         # Lenovo ThinkPad T14s
      default.nix                   # Host definition — composes NixOS + HM modules
      hardware-configuration.nix
    kotoamatsukami/                  # Desktop
      default.nix                   # Host definition — composes NixOS + HM modules
      hardware-configuration.nix
  nixos/                            # NixOS modules (flake.modules.nixos.*)
    common.nix                      # Boot, users, nix settings, networking
    audio.nix                       # PipeWire audio
    cli-utils.nix                   # CLI tools
    fonts.nix                       # Nerd Fonts
    locale.nix                      # Locale and timezone
    nh.nix                          # Nix Helper
    niri.nix                        # Niri window manager
    noctalia.nix                    # Noctalia shell
    plymouth.nix                    # Boot splash
  home-manager/                     # Home Manager modules (flake.modules.homeManager.*)
    browser.nix                     # Firefox
    discord.nix                     # Vesktop
    fastfetch.nix                   # System info
    git.nix                         # Git + GitHub CLI
    jetbrains.nix                   # JetBrains IDEs
    minecraft.nix                   # PrismLauncher
    niri.nix                        # Niri keybindings and settings
    noctalia.nix                    # Noctalia shell config
    shell.nix                       # Bash, kitty, CLI aliases
    stylix.nix                      # Theming
```

## Hosts
 - **Scylla**: Lenovo ThinkPad T14s — Development
 - **Kotoamatsukami**: Desktop — Development, gaming and entertainment
