{
  ignore_history = {
    onEvent = "fish_postexec";
    body = ''
      set -l ignore_list pw senior TmuxNavigateDown TmuxNavigateLeft TmuxNavigateRight TmuxNavigateUp
      set -l cleaned_cmd (string trim -- $argv[1])
      if contains -- $cleaned_cmd $ignore_list
          or string match -q " *" $argv[1]
          history delete --exact --case-sensitive -- $argv[1]
      end
    '';
  };
}
