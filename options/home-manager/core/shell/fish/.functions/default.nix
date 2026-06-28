let
  merged =
    builtins.foldl'
    (acc: file: acc // (import file))
    {}
    [
      ./bd.nix
      # ./error.nix
      ./expand.nix
      ./fzf.nix
      ./greeting.nix
      ./ignore_history.nix
      ./notify.nix
      ./tmux.nix
      ./yazi.nix
    ];
in
  merged
