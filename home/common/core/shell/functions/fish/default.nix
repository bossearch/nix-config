let
  merged =
    builtins.foldl'
    (acc: file: acc // (import file))
    {}
    [
      ./bd.nix
      ./expand.nix
      # ./error.nix
      ./fgrep.nix
      ./fkill.nix
      ./fsys.nix
      ./furl.nix
      ./greeting.nix
      ./ignore_history.nix
      ./notify.nix
      ./sy.nix
      ./tmux_navigate.nix
      ./tmux_pane.nix
      ./tmux_panekill.nix
      ./tmux_tm.nix
      ./tmux_tmkill.nix
    ];
in
  merged
