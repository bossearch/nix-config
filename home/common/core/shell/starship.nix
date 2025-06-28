{lib, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableInteractive = true;
    enableTransience = true;
    settings = {
      format = lib.concatStrings [
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$git_commit"
        "$git_state"
        "$fill"
        "$cmd_duration"
        "$nix_shell"
        "$line_break"
        "$character"
      ];
      fill = {
        symbol = " ";
      };
      hostname = {
        ssh_only = true;
        ssh_symbol = " ";
        format = "[$ssh_symbol]($style)";
        style = "yellow";
      };
      directory = {
        style = "blue";
        home_symbol = "~";
        truncation_symbol = "…/";
        truncation_length = 0;
        truncate_to_repo = false;
        read_only = " 󰌾";
      };
      git_branch = {
        symbol = "";
        format = "[$symbol $branch ]($style)";
        style = "purple";
      };
      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](red)($ahead_behind $stashed)]($style)";
        style = "cyan";
        # use U+00A0 instead <200b>
        conflicted = " ";
        untracked = " ";
        modified = " ";
        staged = " ";
        renamed = " ";
        deleted = " ";
        stashed = "≡";
      };
      git_state = {
        format = ''([\($state ($progress_current/$progress_total)\)]($style)) '';
        style = "red";
      };
      git_commit = {
        format = ''([\($hash$tag\)]($style)) '';
        style = "green";
        commit_hash_length = 8;
        only_detached = true;
        tag_disabled = true;
      };
      cmd_duration = {
        style = "yellow";
        format = "took [$duration]($style)";
      };
      nix_shell = {
        format = ''[  $state(\(nix-$name\))](242)'';
        impure_msg = "impure";
        pure_msg = "pure";
        unknown_msg = "";
      };
      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](blue)";
        vimcmd_visual_symbol = "[❮](purple)";
      };
    };
  };
}
