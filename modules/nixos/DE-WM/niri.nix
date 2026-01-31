{
  pkgs,
  lib,
  config,
  niri,
  ...
}:
{
  options = {
    niri.enable = lib.mkEnableOption "enable niri.nix";
  };

  config = lib.mkIf config.niri.enable {
    nixpkgs.overlays = [ niri.overlays.niri ];
    
    services.displayManager.sddm = {
  enable = true;

  # Enables experimental Wayland support
  wayland.enable = true;
};

	services.xserver = {
		enable = true;
		excludePackages = with pkgs; [
			xterm
		];
	};

	xdg.icons.enable = true;
	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal
			xdg-desktop-portal-gtk
		];
	};

	environment.systemPackages = with pkgs; [
		nautilus
	];

    programs.niri = {
      enable = true;
      package = pkgs.niri-stable;
    };
  };
}
