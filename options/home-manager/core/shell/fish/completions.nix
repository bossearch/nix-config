{
  home.file.".config/fish/completions/rb.fish".text = ''
    # Fish completion for custom `rb` command
    complete -c rb -f -n '__fish_use_subcommand' -a switch -d 'Build, activate, and set as boot default'
    complete -c rb -f -n '__fish_use_subcommand' -a boot   -d 'Build and set as boot default (do not activate)'
    complete -c rb -f -n '__fish_use_subcommand' -a test   -d 'Build and activate (not added to GRUB)'
    complete -c rb -f -n '__fish_use_subcommand' -a list   -d 'List available generations'
    complete -c rb -f -n '__fish_use_subcommand' -a update -d 'Update flake inputs'
    complete -c rb -f -n '__fish_use_subcommand' -a delete -d 'Delete unreachable nix store objects'

  '';
  home.file.".config/fish/completions/hm.fish".text = ''
    # Fish completion for custom `hm` command
    complete -c hm -f -n '__fish_use_subcommand' -a switch -d 'Build and activate new home-manager configuration'
    complete -c hm -f -n '__fish_use_subcommand' -a news   -d 'Show news entries in a pager'
    complete -c hm -f -n '__fish_use_subcommand' -a list   -d 'List available home-manager generations'
    complete -c hm -f -n '__fish_use_subcommand' -a delete -d 'Remove old generations (default: 1 day)'
  '';
}
