# My NixOS-config

Originally based on [CouldBeMathijs/nixos-config](https://github.com/CouldBeMathijs/nixos-config)

Expects to be put in ~/.dotfiles

Do not forget to bring your own hardware-configuration.nix!

## Structure

This configuration follows a **dendritic (tree) pattern**: shared
settings live in a common trunk and host-specific overrides branch out
from it.

```
flake.nix                        # Root – mkHost helper removes duplication
├── hosts/
│   ├── common/
│   │   └── home.nix             # Shared home-manager configuration
│   ├── scylla/                  # Lenovo ThinkPad T14s
│   │   ├── configuration.nix    # Host-specific NixOS settings
│   │   ├── hardware-configuration.nix
│   │   └── home.nix             # Host-specific home-manager overrides
│   └── kotoamatsukami/           # Desktop
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── home.nix
├── modules/
│   ├── nixos/                   # Reusable NixOS modules
│   │   ├── DE-WM/
│   │   ├── programs/
│   │   └── systems/
│   └── home-manager/            # Reusable home-manager modules
│       ├── cli-apps/
│       ├── programs/
│       └── theming/
└── img/
```

### Adding a new host

1. Create `hosts/<hostname>/` with `hardware-configuration.nix`,
   `configuration.nix`, and `home.nix`.
2. Have `home.nix` import `../common/home.nix` and set host-specific
   overrides.
3. Register the host in `flake.nix`:
   ```nix
   <hostname> = mkHost "<hostname>";
   ```

## Hosts
 - Scylla: Lenovo ThinkPad T14s
     - Gnome
     - Development
 - Kotoamatsukami: Desktop
     - Gnome
     - Development, gaming and entertainment
