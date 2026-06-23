{
  config,
  hosts,
  inputs,
  ...
}: let
  toRGBString = inputs.nix-colors.lib.conversions.hexToRGBString ";";
  base0F-rgb = toRGBString config.colorScheme.palette.base0F;
  esc = builtins.fromJSON "\"\\u001b\"";
  feat =
    if hosts.disko.type == "btrfs-luks-impermanence"
    then "luks (yes), impermanence (yes)"
    else if hosts.disko.type == "btrfs-impermanence"
    then "luks (no), impermanence (yes)"
    else if builtins.elem hosts.disko.type ["btrfs-luks" "ext4-luks"]
    then "luks (yes), impermanence (no)"
    else "luks (no), impermanence (no)";
in {
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      "display" = {
        "separator" = " ➜  ";
        "size" = {
          "ndigits" = 1;
        };
        "constants" = [
          "${esc}[38;2;${base0F-rgb}m╭──────────────────────────────────────────────────╮${esc}[0m"
          "${esc}[38;2;${base0F-rgb}m│${esc}[0m${esc}[50C${esc}[38;2;${base0F-rgb}m│${esc}[0m${esc}[50D"
          "${esc}[38;2;${base0F-rgb}m╰──────────────────────────────────────────────────╯${esc}[0m"
        ];
      };
      "logo" = {
        "type" = "none";
      };
      "modules" = [
        {
          "format" = "{$1}";
          "type" = "custom";
        }
        {
          "type" = "custom";
          "format" = "{$2} {#@1} System";
        }
        {
          "key" = "{$2} {#@1}├  ";
          "type" = "title";
        }
        {
          "key" = "{$2} {#@1}├  ";
          "type" = "os";
        }
        {
          "key" = "{$2} {#@1}├  ";
          "type" = "kernel";
        }
        {
          "key" = "{$2} {#@1}├ 󰏖 ";
          "type" = "packages";
        }
        {
          "key" = "{$2} {#@1}└  ";
          "type" = "shell";
        }
        {
          "type" = "custom";
          "format" = "{$2}";
        }
        {
          "type" = "custom";
          "format" = "{$2} {#@2}󱄄 User Interface";
        }
        {
          "key" = "{$2} {#@2}├  ";
          "type" = "wm";
        }
        {
          "key" = "{$2} {#@2}├ 󰍂 ";
          "type" = "lm";
        }
        {
          "key" = "{$2} {#@2}├  ";
          "type" = "theme";
        }
        {
          "key" = "{$2} {#@2}└ 󰇀 ";
          "type" = "cursor";
        }
        {
          "type" = "custom";
          "format" = "{$2}";
        }
        {
          "type" = "custom";
          "format" = "{$2} {#@3}󰪫 Hardware";
        }
        {
          "format" = "{5} ({2})";
          "key" = "{$2} {#@3}├ 󰚗 ";
          "type" = "host";
        }
        {
          "format" = "{1} ({3}/{4})";
          "key" = "{$2} {#@3}├  ";
          "type" = "cpu";
        }
        {
          "format" = "{2}";
          "key" = "{$2} {#@3}├  ";
          "type" = "gpu";
        }
        {
          "key" = "{$2} {#@3}├  ";
          "type" = "memory";
        }
        {
          "compactType" = "original-with-refresh-rate";
          "key" = "{$2} {#@3}└  ";
          "type" = "display";
        }
        {
          "type" = "custom";
          "format" = "{$2}";
        }
        {
          "type" = "custom";
          "format" = "{$2} {#@4}󰋊 Disk/s";
        }
        {
          "format" = "{$2} {#@4}├ \"{20}\"{#@15} ➜  {1} / {2} ({3})";
          "key" = " ";
          "type" = "disk";
        }
        {
          "type" = "custom";
          "format" = "{$2} {#@4}└{#@15} ${feat}";
        }
        {
          "type" = "custom";
          "format" = "{$2}";
        }
        {
          "type" = "custom";
          "format" = "{$2}        {#@0}██{#@1}██{#@2}██{#@3}██{#@4}██{#@5}██{#@6}██{#@7}██{#@8}██{#@9}██{#@10}██{#@11}██{#@12}██{#@13}██{#@14}██{#@15}██";
        }
        {
          "format" = "{$3}";
          "type" = "custom";
        }
      ];
    };
  };
}
