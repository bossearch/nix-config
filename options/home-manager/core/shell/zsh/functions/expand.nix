{
  hosts,
  lib,
  ...
}: {
  home.file.".config/zsh/functions/expand" = lib.mkIf (hosts.shell == "zsh") {
    text = ''
      # expand !!
      function expand-bang() {
          if [[ $LBUFFER =~ '!$' ]]; then
              LBUFFER="''${LBUFFER%?}$history[$(($HISTCMD - 1))]"
          else
              LBUFFER+='!'
          fi
      }
      zle -N expand-bang
      bindkey '!' expand-bang

      # expand !$
      function expand-args() {
          if [[ $LBUFFER =~ '!$' ]]; then
              local last_cmd="$history[$(($HISTCMD - 1))]"
              local last_arg=("''${(z)last_cmd}")
              LBUFFER="''${LBUFFER%?}$last_arg[-1]"
          else
              LBUFFER+='$'
          fi
      }
      zle -N expand-args
      bindkey '$' expand-args

      # expand ..
      function expand-dots() {
          if [[ "$LBUFFER" == "." ]]; then
              LBUFFER="cd .."
          elif [[ "$LBUFFER" =~ '^cd (\.\./)*\.\.$' ]]; then
              LBUFFER+='/..'
          else
              LBUFFER+='.'
          fi
      }
      zle -N expand-dots
      bindkey '.' expand-dots
    '';
  };
}
