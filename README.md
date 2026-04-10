# ❄️ Nils' NixOS & Home Manager Configuration

This is my personal NixOS and Home Manager configuration, structured using the **Dendritic Nix pattern**. This pattern uses [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree) to maintain a clean, modular, and organized file structure.

Originally based on the [nixos-config by CouldBeMathijs](https://github.com/CouldBeMathijs/nixos-config).

## 🌟 Features & Stack

My system is built around modern Wayland technologies with a strong focus on a seamless, dark aesthetic.

  * **Window Manager:** [Niri](https://www.google.com/search?q=https://github.com/YaLTeR/niri) (Scrollable-tiling Wayland compositor).
  * **Desktop Shell/Bar:** [Noctalia](https://github.com/noctalia-dev/noctalia-shell).
  * **Terminal:** Kitty.
  * **Shell:** Zsh with Starship prompt, Zoxide, and extended CLI tools (Bat, Eza, Fastfetch, Btop).
  * **Editor:** Zed (with support for Nix, Python, C/C++, Rust, and more).
  * **Theming:** Fully and globally managed by [Stylix](https://github.com/danth/stylix), using the **Tokyo Night Storm** theme (often overridden by wallpaper). System-wide fonts are *JetBrainsMono Nerd Font* and *Noto Color Emoji*.
  * **Applications:** Firefox, Vesktop (Discord), Thunar, OBS Studio, Audacity, Steam, and VirtualBox.

## 🖥️ Hosts

This flake currently manages two systems:

1.  **Scylla** (Lenovo ThinkPad T14s Gen 1)
      * *Purpose:* Development and work on the go.
      * *Specifics:* Includes VirtualBox settings and UPower power management.
2.  **Kotoamatsukami** (Desktop)
      * *Purpose:* Development, gaming, and entertainment.
      * *Specifics:* Includes Steam (with open ports for Remote Play and Dedicated Servers).

## 📂 Directory Structure

The configuration follows a strict hierarchy thanks to `import-tree`:

```text
flake.nix                           # Minimal entry point: contains only inputs and import-tree
modules/
  flake/                            # Configuration for the Flake itself
    flake.nix                       # Flake-parts setup (flakeModules imports)
    lib.nix                         # Custom helper functions like 'mkNixosHost'
    systems.nix                     # Architecture settings (x86_64-linux) and formatter
  hosts/
    scylla/                         # Host-specific definition (Laptop)
      default.nix                   # Combines the desired NixOS and Home Manager modules
      _hardware-configuration.nix
    kotoamatsukami/                 # Host-specific definition (Desktop)
      default.nix                   
      _hardware-configuration.nix
  nixos/                            # System-wide (NixOS) modules
    common.nix                      # Bootloader, networking, users, Nix settings
    audio.nix                       # PipeWire audio configuration
    cli-utils.nix                   # Basic CLI tools (git, btop, wget, etc.)
    niri.nix                        # Niri system installation and Greetd/Regreet login
    ...
  home-manager/                     # User-specific (Home Manager) modules
    niri.nix                        # Niri keybindings, window rules, and startup applications
    noctalia.nix                    # Configuration of the top bar and widgets
    shell.nix                       # Zsh, aliases, and terminal tools
    zed.nix                         # Zed editor configuration and language servers
    ...
```

## ⌨️ Main Keybindings (Niri)

My workflow is heavily keyboard-driven. Here are the default Niri keybindings (`Mod` = Super/Windows key):

| Keybinding | Action |
| :--- | :--- |
| `Mod + Return` | Open Terminal (Kitty) |
| `Mod + D` | Open App Launcher (Noctalia) |
| `Mod + B` | Open Browser (Firefox) |
| `Mod + F` | Open File Manager (Thunar) |
| `Mod + Q` | Close current window |
| `Mod + L` | Lock screen (Noctalia Lock) |
| `Mod + S` | Take a screenshot |
| `Mod + Arrows / Scroll` | Navigate between workspaces and columns |
| `Mod + 1 to 5` | Go to specific workspace |

## 🚀 Installation & Usage

Note: The configuration expects to be placed in `~/.dotfiles` by default.

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/NilsPils06/nixos-config ~/.dotfiles
    cd ~/.dotfiles
    ```

2.  **Generate hardware configuration:**
    Copy your actual hardware configuration to the correct host folder. (For example, for Scylla):

    ```bash
    cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/modules/hosts/scylla/_hardware-configuration.nix
    ```

3.  **Apply the configuration:**
    The configuration utilizes `nh` (Nix Helper). You can simply use the following custom alias command in the terminal:

    ```bash
    switch
    ```

    *This alias automatically adds new files to git (`git add .`) and runs `nh os switch`.*
