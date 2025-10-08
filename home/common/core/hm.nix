{pkgs, ...}: let
  script = ''
    set -e

    HOSTNAME=$(hostname)
    USERNAME=$(whoami)

    pushd ~/.nix-config >/dev/null

    man="\
    hm <\e[1;33moperations\e[0m> = home-manager <\e[1;33moperations\e[0m> --flake .#$USERNAME@$HOSTNAME

    \e[1;33mswitch\e[0m  Build and activate the new home-manager configuration.
    \e[1;33mnews\e[0m    Show news entries in a pager.
    \e[1;33mlist\e[0m    List the available home-manager generations.
    \e[1;33mdelete\e[0m  Remove generations that are older than a specified timestamp.
    "

    OPTIONS=""

    case "$1" in
    "switch") OPTIONS="switch -b backup --flake ." ;;
    "news")
      home-manager news --flake .
      exit 0
      ;;
    "list")
      home-manager generations
      exit 0
      ;;
    "delete") OPTIONS="expire-generations -d" ;;
    *)
      printf "$man"
      exit 0
      ;;
    esac

    git diff -U0 --no-prefix '*.nix' ':!hosts/*' ':!modules/nixos/*' | rg '^(?:diff --git |(?:\+[^+]|-[^-]))' | sed -E \
      -e 's/^(diff --git .*)/\n\x1b[1m\1\x1b[0m/' \
      -e 's/^(\+)(.*)/\x1b[32m+\2\x1b[0m/' \
      -e 's/^(-)(.*)/\x1b[31m-\2\x1b[0m/'

    echo ""
    git status --short '*.nix' ':!hosts/*' ':!modules/nixos/*'

    git add '*.*' ':!hosts/*' ':!modules/nixos/*'

    trap 'tput cnorm; git reset -q; echo -e "\nAborted by user."; exit 1' SIGINT
    read -p "Are you sure you want to proceed? (y/N): " confirm
    confirm="''${confirm:-n}"
    if [[ ! "$confirm" =~ ^[yY]$ ]]; then
      git reset -q
      echo "Aborted."
      popd >/dev/null
      exit 0
    fi

    echo ""
    echo -e "Home Manager running for \e[33m$USERNAME\e[0m@\e[1m$HOSTNAME\e[0m"

    spinner() {
      local pid=$1
      local delay=0.1
      local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
      local max_width=$(($(tput cols) - 6))
      tput civis

      while ps -p $pid &>/dev/null; do
        for ((i = 0; i < ''${#spin}; i++)); do
          local last_log=$(tail -n 1 .hm.log | cut -c 1-$max_width)
          echo -ne "\r\033[K\e[33m[''${spin:$i:1}]\e[0m $last_log"
          sleep $delay
        done
      done

      echo -ne "\r\033[K"
    }

    home-manager $OPTIONS &>.hm.log &
    rebuild_pid=$!

    spinner $rebuild_pid
    tput cnorm

    if wait $rebuild_pid; then
      CURRENT=$(home-manager generations | sed -n '2p')
      echo -e "\e[32mDone\e[0m - \e[1m$CURRENT\e[0m"
      notify-send -e "Home Manager" "Done" --icon=software-update-available
    else
      notify-send -e "Home Manager" "Error" --icon=software-update-urgent --urgency=critical
      git reset -q

      if read -p "Open log? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        nvim .hm.log
      fi

      popd >/dev/null
      exit 1
    fi
  '';
in {
  home.packages = [
    (pkgs.writeShellScriptBin "hm" script)
  ];
}
