{
  savecmd = {
    onEvent = "fish_preexec";
    body = ''
      set -g __last_cmd $argv
    '';
  };
}
