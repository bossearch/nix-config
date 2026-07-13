{hosts, ...}: {
  programs.oh-my-posh = {
    enable = hosts.shell == "zsh";
    enableZshIntegration = true;
    settings = {
      version = 4;
      final_space = true;
      blocks = [
        {
          alignment = "left";
          type = "prompt";
          newline = true;
          segments = [
            {
              background = "transparent";
              foreground = "blue";
              properties = {
                style = "full";
              };
              style = "plain";
              template = "{{ .Path }}";
              type = "path";
            }
            {
              background = "transparent";
              foreground = "p:grey";
              properties = {
                branch_icon = "";
                merge_icon = "merging ";
                rebase_icon = "rebasing ";
                revert_icon = "reverting ";
                cherry_pick_icon = "cherry picking ";
                commit_icon = "@";
                no_commit_icon = "empty ";
                tag_icon = "tag ";
                fetch_status = true;
              };
              style = "plain";
              template = " <magenta>{{ .HEAD }}</><red>{{ if or (.Working.Changed) (.Staging.Changed) }} *{{ end }}</> <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}{{ if gt .StashCount 0 }} ≡{{ end }}</>";
              type = "git";
            }
          ];
        }
        {
          alignment = "right";
          type = "prompt";
          segments = [
            {
              background = "transparent";
              foreground = "grey";
              style = "plain";
              template = "{{ if .Env.IN_NIX_SHELL }}(󱄅 {{ .Type }}){{ end }}";
              type = "nix-shell";
            }
            {
              background = "transparent";
              foreground = "yellow";
              properties = {
                threshold = 5000;
                style = "round";
              };
              style = "plain";
              template = " {{ .FormattedMs }}";
              type = "executiontime";
            }
          ];
        }
        {
          alignment = "left";
          type = "prompt";
          newline = true;
          segments = [
            {
              background = "transparent";
              foreground_templates = [
                "{{if gt .Code 0}}red{{end}}"
                "{{if eq .Code 0}}green{{end}}"
              ];
              style = "plain";
              template = "❯";
              type = "text";
            }
          ];
        }
      ];
      secondary_prompt = {
        background = "transparent";
        foreground = "green";
        template = "❯❯ ";
      };
      transient_prompt = {
        background = "transparent";
        foreground_templates = [
          "{{if gt .Code 0}}red{{end}}"
          "{{if eq .Code 0}}green{{end}}"
        ];
        template = "❯ ";
      };
    };
  };
}
