# ❄️ Nils' NixOS & Home Manager Configuration

This is my personal NixOS and Home Manager configuration, structured using the **Dendritic Nix pattern**. This pattern uses [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree) to maintain a clean, modular, and organized file structure.

Originally based on the [nixos-config by CouldBeMathijs](https://github.com/CouldBeMathijs/nixos-config).

## 🌟 Features & Stack

My system is built around modern Wayland technologies with a strong focus on a seamless, dark aesthetic.

* **Package Manager:** [Lix](https://lix.systems/) (A faster, more modern Nix fork) managed via overlays.
* **Nix Helper:** [nh](https://github.com/viperML/nh) with automatic daily cleanup (`--keep-since 1d --keep 3`).
* **Window Manager:** [Hyprland](https://hyprland.org/) (Dynamic tiling Wayland compositor with XWayland satellite and portals).
* **Desktop Shell/Bar:** [Ambxst](https://github.com/Axenide/Ambxst) (An Axtremely customizable desktop shell for Wayland compositors).
* **Login Manager:** SDDM with the *sddm-astronaut-theme* (Wayland enabled).
* **Boot:** Plymouth for a silent, flicker-free themed boot experience and systemd-boot.
* **Terminal:** Kitty.
* **Shell:** Zsh with Starship prompt, Zoxide, and extended CLI tools (Bat, Eza, Fastfetch with custom Goku logo, Trash-cli, TLDR, ytm-dl).
* **Editor & Development:** [Zed](https://zed.dev/) (with language servers for Nix (`nil`), Python (`pyright`), C/C++ (`clangd`), Rust, HTML, R, and Google Antigravity CLI integration), direnv & nix-direnv, and Comma (`nix-index-database`).
* **Theming:** Globally managed by [Stylix](https://github.com/danth/stylix) using the **Tokyo Night Storm** base16 theme. System-wide fonts are *JetBrainsMono Nerd Font* and *Noto Color Emoji*, paired with *Capitaine Cursors* and *Nordzy* icons.
* **Applications & Gaming:** Firefox, Vesktop (Discord), Thunar, Steam, Prism Launcher (Minecraft), GIMP, Kdenlive...

## 🖥️ Hosts

This flake currently manages two systems:

1. **kotoamatsukami** (Desktop)
   * *Purpose:* Development, gaming, and entertainment.
   * *Specifics:* Steam (with open ports for Remote Play and Dedicated Servers), Prism Launcher (Minecraft), AMD GPU hardware acceleration (`radeonsi` / VA-API)...
2. **tsukuyomi** (Lenovo ThinkPad T14s Gen 6)
   * *Purpose:* Development and portable workstation.
   * *Specifics:* UPower power management, display brightness controls (`brightnessctl`)...

## 📂 Directory Structure

The configuration follows a strict dendritic hierarchy thanks to `import-tree`:

```text
flake.nix                           # Minimal entry point: contains inputs and import-tree call
modules/
  flake/                            # Flake configuration, helper functions, and systems
    flake.nix                       # Imports flakeModules (flake-parts & home-manager)
    lib.nix                         # Helper functions (e.g. 'mkNixosHost')
    systems.nix                     # Supported systems (x86_64-linux) and nixfmt formatter
  hosts/                            # Host definitions
    kotoamatsukami/                 # Desktop host
      default.nix                   # Modules list and host-specific settings (AMD GPU, Steam, AAGL)
      _hardware-configuration.nix
    tsukuyomi/                      # Laptop host (ThinkPad T14s Gen 6)
      default.nix                   # Modules list and host-specific settings (UPower)
      _hardware-configuration.nix
  nixos/                            # System-wide (NixOS) modules
    audio.nix                       # PipeWire audio configuration
    cli-utils.nix                   # System CLI utilities (git, btop, tree, unzip, etc.)
    common.nix                      # Bootloader, networking, user account, Lix setup
    fonts.nix                       # JetBrainsMono Nerd Font package
    hyprland.nix                    # Hyprland system config, portal integrations & Thunar
    locale.nix                      # Timezone (Europe/Brussels) and keyboard layout (us alt-intl)
    nh.nix                          # Nh (Nix Helper) integration and auto-cleanup rules
    ollama.nix                      # Local Ollama service with ROCm acceleration
    plymouth.nix                    # Plymouth silent boot splash configuration
    sddm.nix                        # SDDM display manager with astronaut theme
    stylix.nix                      # NixOS-level Stylix theming
  home-manager/                     # User-specific (Home Manager) modules
    browser.nix                     # Firefox browser configuration
    direnv.nix                      # Direnv and nix-direnv shell integration
    discord.nix                     # Vesktop Discord client configuration and autostart
    fastfetch.nix                   # Fastfetch configuration with custom Goku logo
    git.nix                         # Git credentials and GitHub CLI integration
    hyprland.nix                    # Hyprland keybindings, rules, and Ambxst Shell
    kdenlive.nix                    # Video editing and screen recording tools
    minecraft.nix                   # Prism Launcher for Minecraft
    shell.nix                       # Zsh, Starship, Kitty, Zoxide, aliases, and ytm-dl script
    stylix.nix                      # Home-manager Stylix settings (icons, cursor, application themes)
    zed.nix                         # Zed editor configuration, language servers & ACP agent
```

## ⌨️ Main Keybindings (Hyprland)

My workflow is heavily keyboard-driven. Here are the primary Hyprland keybindings (`Mod` = Super/Windows key):

| Keybinding | Action |
| :--- | :--- |
| `Mod + Return` | Open Terminal (Kitty) |
| `Mod + Q` | Close active window (`killactive`) |
| `Mod + Shift + F` | Toggle fullscreen |
| `Mod + D` | Open App Launcher (Ambxst) |
| `Mod + S` | Toggle Dashboard (Ambxst) |
| `Mod + Shift + E` | Open Power Menu (Ambxst) |
| `Mod + B` | Open Browser (Firefox) |
| `Mod + F` | Open File Manager (Thunar) |
| `Mod + X` | Toggle floating mode for active window |
| `Mod + Tab` | Cycle to next window (`cyclenext`) |
| `Alt + Tab` | Window Switcher / Task Switcher (Rofi) |
| `Mod + Left / Right` | Switch to previous / next workspace |
| `Mod + 1 to 9` | Switch to workspace 1–9 |
| `Mod + Shift + 1 to 9` | Move active window to workspace 1–9 |
| `XF86AudioMute` | Toggle audio mute (`wpctl`) |
| `XF86AudioRaiseVolume` / `LowerVolume` | Raise / lower audio volume by 5% (`wpctl`) |
| `XF86MonBrightnessUp` / `Down` | Raise / lower display brightness by 5% (`brightnessctl`) |

## 🚀 Installation & Usage

Note: The configuration expects to be placed in `~/.dotfiles` by default.

1. **Clone the repository:**

   ```bash
   git clone https://github.com/NilsPils06/nixos-config ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Generate hardware configuration:**
   Copy your actual hardware configuration to the appropriate host folder (e.g. for `kotoamatsukami` or `tsukuyomi`):

   ```bash
   cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/modules/hosts/tsukuyomi/_hardware-configuration.nix
   ```

3. **Apply the configuration:**
   The configuration utilizes `nh` (Nix Helper). You can simply use the custom alias in your terminal:

   ```bash
   switch
   ```

   *This alias automatically stages changes in git (`git add .`) and runs `nh os switch`.*
