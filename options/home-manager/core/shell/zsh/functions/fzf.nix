{
  hosts,
  lib,
  ...
}: {
  home.file.".config/zsh/functions/fzf" = lib.mkIf (hosts.shell == "zsh") {
    text = ''
      fkill() {
        local processes
        if [ "$UID" != "0" ]; then
          processes=$(ps -U $UID -o pid,%cpu,%mem,args --sort=-%mem --no-headers)
        else
          processes=$(ps -A -o pid,%cpu,%mem,args --sort=-%mem --no-headers)
        fi

        local selected_pid
        selected_pid=$(echo "$processes" | awk '
          {
            pid = $1; cpu = $2; mem = $3; bin = $4
            sub(/.*\//, "", bin)
            printf "%-7s %-5s %-5s %s\n", pid, cpu, mem, bin
          }
        ' | fzf --prompt="fkill ❯ " --multi | awk '{print $1}')

        if [ -n "$selected_pid" ]; then
          echo "$selected_pid" | xargs kill -''${1:-9}
        fi
      }

      fgrep() {
        if [ "$#" -eq 0 ]; then
          echo "Need a string to search for!"
          return 1
        fi

        local selected_file

        selected_file=$(rg --hidden --follow --files-with-matches --no-messages -- "$1" | fzf \
          --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 -- '$1' || rg --hidden --follow --ignore-case --pretty --context 10 -- '$1' {}" \
          --prompt="fgrep ❯ ")

        if [ -n "$selected_file" ]; then
          nvim "$selected_file"
        fi
      }

      fsys() {
        _build_cmd() {
          local mode="$1" action="$2" unit="$3" prefix=""
          [[ "$mode" == "--system" ]] && prefix="sudo "

          case "$action" in
            journal)        echo "''${prefix}journalctl ''${mode} -u ''${unit} -f" ;;
            enable|disable) echo "''${prefix}systemctl ''${mode} ''${action} --now ''${unit}" ;;
            *)              echo "''${prefix}systemctl ''${mode} ''${action} ''${unit}" ;;
          esac
        }

        _sysrun() {
          local mode="$1" action="$2" list_cmd=""
          case "$action" in
            start)   list_cmd="systemctl ''${mode} list-units --type=service --all --state=inactive,failed --plain" ;;
            stop)    list_cmd="systemctl ''${mode} list-units --type=service --state=active,running --plain" ;;
            enable)  list_cmd="systemctl ''${mode} list-unit-files --type=service --state=disabled" ;;
            disable) list_cmd="systemctl ''${mode} list-unit-files --type=service --state=enabled" ;;
            *)       list_cmd="systemctl ''${mode} list-units --type=service --all --plain" ;;
          esac

          local units
          units=$(eval "''${list_cmd} --no-legend" | awk '$1 ~ /\.service$/ {print $1}' | fzf --prompt="fsys ❯ " --multi --ansi --reverse --preview="SYSTEMD_COLORS=1 systemctl ''${mode} status {} --no-pager")

          # Convert multi-selection newlines into a clean, space-separated sequence
          units=$(echo "''${units}" | tr '\n' ' ' | xargs)

          if [[ -n "''${units}" ]]; then
            _build_cmd "''${mode}" "''${action}" "''${units}"
          fi
        }

        local mode="--system"
        local action=""

        # Emulate Fish argparse by reading argument array switches directly
        for arg in "$@"; do
          case "$arg" in
            -u) mode="--user" ;;
            --start) action="start" ;;
            --stop) action="stop" ;;
            --restart) action="restart" ;;
            --status) action="status" ;;
            --enable) action="enable" ;;
            --disable) action="disable" ;;
            --journal) action="journal" ;;
          esac
        done

        local final_cmd=""
        if [[ -z "''${action}" ]]; then
          action=$(printf "\033[0;33mstatus\033[0m\n\033[0;33mrestart\033[0m\n\033[0;32mstart\033[0m\n\033[0;31mstop\033[0m\n\033[0;32menable\033[0m\n\033[0;31mdisable\033[0m\n\033[0;36mjournal\033[0m" | fzf --reverse --ansi --prompt="fsys ❯ ")
          action=$(echo "''${action}" | xargs)
        fi

        if [[ -n "''${action}" ]]; then
          final_cmd=$(_sysrun "''${mode}" "''${action}")
        fi

        if [[ -n "''${final_cmd}" ]]; then
          if [[ -n "$ZLE_STATE" ]]; then
            # If invoked as an interactive Zsh widget bind, write and accept the line
            BUFFER="''${final_cmd}"
            zle accept-line
          else
            # If run directly as a CLI function command, save to history and execute
            print -s "''${final_cmd}"
            eval "''${final_cmd}"
          fi
        else
          if [[ -n "$ZLE_STATE" ]]; then
            zle repaint
          fi
        fi
      }
    '';
  };
}
