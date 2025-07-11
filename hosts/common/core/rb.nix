{pkgs, ...}: let
  script = ''
    set -e

    # Get the hostname
    HOSTNAME=$(hostname)

    # cd to your config dir
    pushd ~/.nix-config >/dev/null

    man="\
    rb <\e[1;33moperations\e[0m> = sudo nixos-rebuild <\e[1;33moperations\e[0m> --flake .#$HOSTNAME

    \e[1;33mswitch\e[0m  Build and activate the new configuration, and make it the boot default.

    \e[1;33mboot\e[0m    Build the new configuration and make it the boot default (as with nixos-rebuild switch),
            but do not activate it. That is, the system continues to run the previous configuration until the next reboot.

    \e[1;33mtest\e[0m    Build and activate the new configuration, but do not add it to the GRUB boot menu.
            Thus, if you reboot the system (or if it crashes), you will automatically revert to the default configuration
            (i.e. the configuration resulting from the last call to nixos-rebuild switch or nixos-rebuild boot).

    \e[1;33mlist\e[0m    List the available generations in a similar manner to the boot loader menu. It shows the  generation number,
            build  date and time, NixOS version, kernel version and the configuration revision.

    \e[1;33mupdate\e[0m  Is an alias of 'nix flake update' command updates the inputs specified in the 'flake.nix' file
            and refreshes the 'flake.lock' file to ensure that the latest versions of dependencies are used.

    \e[1;33mdelete\e[0m  Is an alias of 'nix-collect-garbage --delete-old'. That is, it deletes all unreachable
            store objects ⟨@docroot@/store/store-object.md⟩ in the Nix store to clean up your system.
    "

    # Default OPTIONS (Prevent empty execution)
    OPTIONS=""

    case "$1" in
    "switch") OPTIONS="switch" ;;
    "boot") OPTIONS="boot" ;;
    "test") OPTIONS="test" ;;
    "list")
      nixos-rebuild list-generations
      exit 0
      ;;
    "update")
      nix flake update
      cd ~/.nix-config/hosts/minimal
      nix flake update
      exit 0
      ;;
    "delete")
      sudo nix-collect-garbage -d
      exit 0
      ;;
    *)
      printf "$man"
      exit 0
      ;;
    esac

    # Show your changes
    git diff -U0 --no-prefix '*.nix' ':!home/*' ':!modules/home-manager/*' | rg '^(?:diff --git |(?:\+[^+]|-[^-]))' | sed -E \
      -e 's/^(diff --git .*)/\n\x1b[1m\1\x1b[0m/' \
      -e 's/^(\+)(.*)/\x1b[32m+\2\x1b[0m/' \
      -e 's/^(-)(.*)/\x1b[31m-\2\x1b[0m/'
    echo ""
    git status --short '*.nix' ':!home/*' ':!modules/home-manager/*'

    # Stage all changes
    git add '*.*' ':!home/*' ':!modules/home-manager/*'

    trap 'tput cnorm; git reset -q; echo -e "\nAborted by user."; exit 1' SIGINT
    read -p "Are you sure you want to proceed? (y/N): " confirm
    confirm="''${confirm:-y}"
    if [[ ! "$confirm" =~ ^[yY]$ ]]; then
      git reset -q
      echo "Aborted."
      popd >/dev/null
      exit 0
    fi

    echo ""
    echo -e "NixOS Rebuilding for \e[1m$HOSTNAME\e[0m (mode: \e[33m$OPTIONS\e[0m)"

    # Ensure sudo doesn't ask for a password mid-way
    sudo -v

    # Function to show a spinner
    spinner() {
      local pid=$1
      local delay=0.1
      local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
      local max_width=$(($(tput cols) - 6))
      tput civis

      while ps -p $pid &>/dev/null; do
        for i in $(seq 0 $((''${#spin} - 1))); do
          local last_log=$(tail -n 1 .nixos.log | cut -c 1-$max_width) # Get the last line from the log file
          echo -ne "\r\033[K\e[33m[''${spin:$i:1}]\e[0m $last_log"
          sleep $delay
        done
      done

      echo -ne "\r\033[K" # Clear the spinner line after finishing
    }

    # Run nixos-rebuild in the background
    sudo nixos-rebuild "$OPTIONS" --flake ".#$HOSTNAME" &>.nixos.log &
    rebuild_pid=$!

    # Start spinner animation
    spinner $rebuild_pid
    tput cnorm

    # Check exit status
    if wait $rebuild_pid; then
      CURRENT=$(nixos-rebuild list-generations | grep current | tr -s ' ' | tr -d '*')
      echo -e "\e[32mDone\e[0m - \e[1m$CURRENT\e[0m"
      notify-send -e "NixOS Rebuild ($OPTIONS)" "Done" --icon=software-update-available
    else
      notify-send -e "NixOS Rebuild ($OPTIONS)" "Error" --icon=software-update-urgent --urgency=critical
      git reset -q

      echo ""
      cat .nixos.log | grep --color error
      echo ""

      if read -p "Open log? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        nvim .nixos.log
      fi

      popd >/dev/null
      exit 1
    fi
  '';
in {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "rb" script)
  ];
}
