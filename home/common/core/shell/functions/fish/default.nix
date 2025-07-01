let
  merged =
    builtins.foldl'
    (acc: file: acc // (import file))
    {}
    [
      ./bd.nix
      ./expand.nix
      ./error.nix
      ./fgrep.nix
      ./fkill.nix
      ./fsys.nix
      ./furl.nix
      ./greeting.nix
      ./notify.nix
      ./sy.nix
      ./tmux-pane.nix
      ./tmux-panekill.nix
      ./tmux-tm.nix
      ./tmux-tmkill.nix
    ];
in
  merged
