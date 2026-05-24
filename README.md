# ❄️ Nils' NixOS & Home Manager Configuration

This is my personal NixOS and Home Manager configuration, structured using the **Dendritic Nix pattern**. This pattern uses [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree) to maintain a clean, modular, and organized file structure.

Originally based on the [nixos-config by CouldBeMathijs](https://github.com/CouldBeMathijs/nixos-config).

## 🌟 Features & Stack

My system is built around modern Wayland technologies with a focus on speed, aesthetics, and productivity.

  * **Package Manager:** [Lix](https://lix.systems/) (A faster, more modern Nix fork).
  * **Window Manager:** [Niri](https://github.com/YaLTeR/niri) (Scrollable-tiling Wayland compositor).
  * **Desktop Shell/Bar:** [Caelestia](https://github.com/caelestia-dots/shell) (Highly customizable shell for Niri).
  * **Login Manager:** SDDM with the *Japanese Aesthetic* astronaut theme.
  * **Boot:** Plymouth for a flicker-free, themed boot experience.
  * **Terminal:** Kitty.
  * **Shell:** Zsh with Starship prompt, Zoxide, and extended CLI tools (Bat, Eza, Fastfetch, Btop, Direnv).
  * **Editor:** Zed (with support for Nix, Python, C/C++, Rust, and more).
  * **Theming:** Fully and globally managed by [Stylix](https://github.com/danth/stylix).
  * **AI:** Ollama enabled system-wide for local LLMs.
  * **Database:** PostgreSQL pre-configured for development.
  * **Applications:** Firefox, Vesktop (Discord), Thunar, Steam, Minecraft, and Kdenlive.

## 🖥️ Hosts

This flake currently manages two systems:

1.  **Kotoamatsukami** (Desktop)
      * *Purpose:* Development, gaming, and entertainment.
      * *Specifics:* Includes Steam (with open ports for Remote Play), Ollama, and PostgreSQL.
2.  **Tsukuyomi** (Lenovo Thinkpad T14s Gen 6)
      * *Purpose:* Development and work on the go.
      * *Specifics:* Includes VirtualBox settings, UPower power management, Ollama, and PostgreSQL.

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
    tsukuyomi/                      # Laptop host definition
      default.nix                   # Combines NixOS and Home Manager modules
      _hardware-configuration.nix
    kotoamatsukami/                 # Desktop host definition
      default.nix                   
      _hardware-configuration.nix
  nixos/                            # System-wide (NixOS) modules
    common.nix                      # Lix, bootloader, networking, users, Nix settings
    audio.nix                       # PipeWire audio configuration
    cli-utils.nix                   # Basic CLI tools (git, btop, wget, etc.)
    niri.nix                        # Niri system installation
    sddm.nix                        # SDDM login manager with Astronaut theme
    plymouth.nix                    # Boot splash screen
    ollama.nix                      # Local LLM service
    nh.nix                          # Nix Helper (nh) configuration
    ...
  home-manager/                     # User-specific (Home Manager) modules
    niri.nix                        # Niri keybindings and window rules
    caelestia.nix                   # Caelestia shell configuration
    shell.nix                       # Zsh, aliases, and terminal tools
    zed.nix                         # Zed editor configuration
    fastfetch.nix                   # Custom fastfetch layout
    ...
```

## ⌨️ Main Keybindings (Niri)

My workflow is heavily keyboard-driven. Here are the default Niri keybindings (`Mod` = Super/Windows key):

| Keybinding | Action |
| :--- | :--- |
| `Mod + Return` | Open Terminal (Kitty) |
| `Mod + D` | Open App Launcher (Caelestia) |
| `Mod + S` | Toggle Dashboard (Caelestia) |
| `Mod + Tab` | Toggle Overview |
| `Mod + B` | Open Browser (Firefox) |
| `Mod + F` | Open File Manager (Thunar) |
| `Mod + Q` | Close current window |
| `Mod + Shift + E` | Open Session Menu |
| `Mod + Arrows` | Navigate between workspaces and columns |
| `Mod + 1 to 5` | Go to specific workspace |
| `Mod + Print` | Take a screenshot |

## 🚀 Installation & Usage

Note: The configuration expects to be placed in `~/.dotfiles` by default.

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/NilsPils06/nixos-config ~/.dotfiles
    cd ~/.dotfiles
    ```

2.  **Generate hardware configuration:**
    Copy your actual hardware configuration to the correct host folder. (For example, for `kotoamatsukami`):

    ```bash
    cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/modules/hosts/kotoamatsukami/_hardware-configuration.nix
    ```

3.  **Apply the configuration:**
    The configuration utilizes `nh` (Nix Helper). You can simply use the following command:

    ```bash
    nh os switch .
    ```

    *If you have the `switch` alias configured (as seen in `shell.nix`), you can just run `switch`.*
