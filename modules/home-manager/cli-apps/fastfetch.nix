{ pkgs, lib, config, options, ... }:
let 
	fastfetch-folder = pkgs.runCommand "fastfetch-folder" { } ''
        mkdir -p $out/
        cp -r ${../../../img/fastfetch} $out/fastfetch
        '';
in
{
        options = {
                fastfetch.enable = lib.mkEnableOption "Enable fastfetch configuration";
        };

        config = lib.mkIf config.shell.enable {
                home.packages = with pkgs; [ fastfetch ];
                # Fastfetch configuration
                programs.fastfetch = {
                        enable = true;
                        settings = {
                                "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
                                logo = {
                                	type = "kitty";
					source = "${fastfetch-folder}/fastfetch/*.png";
					height = 18;
					padding = {
					   top = 3;	
					};
				};
                                display = {
                                        separator = " · ";
                                        color = "bright_blue";
                                };
                                modules = [
                                        {
                                                type = "custom";
                                                format = "┌─────────── Hardware Information ───────────┐";
                                        }
                                        {
                                                type = "host";
                                                key = "  󰌢";
                                        }
                                        {
                                                type = "cpu";
                                                key = "  ";
                                        }
                                        {
                                                type = "gpu";
                                                detectionMethod = "pci";
                                                key = "  ";
                                        }
                                        {
                                                type = "display";
                                                key = "  󱄄";
                                        }
                                        {
                                                type = "memory";
                                                key = "  ";
                                        }
                                        {
                                                type = "custom";
                                                format = "├─────────── Software Information ───────────┤";
                                        }
                                        {
                                                type = "os";
                                                key = "  ";
                                        }
                                        {
                                                type = "kernel";
                                                key = "  ";
                                                format = "{1} {2}";
                                        }
                                        {
                                                type = "wm";
                                                key = "  ";
                                        }
                                        {
                                                type = "shell";
                                                key = "  ";
                                        }
                                        {
                                                type = "custom";
                                                format = "|───────────── Uptime / Age ─────────────────|";
                                        }
                                        {
                                                type = "command";
                                                key = "  OS Age ";
                                                keyColor = "magenta";
                                                text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
                                        }
                                        {
                                                type = "uptime";
                                                key = "  Uptime ";
                                                keyColor = "magenta";
                                        }
                                        {
                                                type = "custom";
                                                format = "└────────────────────────────────────────────┘";
                                        }
                                        {
                                                type = "colors";
                                                paddingLeft = 2;
                                                symbol = "circle";
                                        }
                                ];
                        };
                };
        };
}
