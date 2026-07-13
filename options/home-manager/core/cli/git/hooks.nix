{
  config,
  hosts,
  ...
}: {
  home.file.".config/git/gh-hooks.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      STATE_FILE="${config.xdg.cacheHome}/${hosts.username}/gh-state"
      touch $STATE_FILE

      is_private_repo() {
        local is_private
        is_private=$(git config repo.is-private || true)
        if [ -z "$is_private" ]; then
          is_private=$(gh repo view --json isPrivate -q '.isPrivate' 2>/dev/null || echo "true")
          git config repo.is-private "$is_private"
        fi
        [ "$is_private" == "true" ]
      }

      get_state() {
        IFS=':' read -r saved_date commit_count last_level <"$STATE_FILE" || true
        local today
        today=$(date -I)

        if [ "''${saved_date:-}" != "$today" ]; then
          echo "$today:0:0"
        else
          echo "$saved_date:$commit_count:$last_level"
        fi
      }

      case "''${1:-}" in
      commit)
        if is_private_repo; then exit 0; fi

        IFS=':' read -r today commit_count last_level <<<"$(get_state)"
        commit_count=$((commit_count + 1))

        echo "$today:$commit_count:$last_level" >"$STATE_FILE"
        ;;

      push)
        if is_private_repo; then exit 0; fi
        IFS=':' read -r today commit_count last_level <<<"$(get_state)"
        current_level=0

        if [ "$commit_count" -ge 11 ]; then
          current_level=3
        elif [ "$commit_count" -ge 5 ]; then
          current_level=2
        elif [ "$commit_count" -ge 1 ]; then
          current_level=1
        fi

        if [ "$current_level" -gt "$last_level" ]; then
          echo "$today:$commit_count:$current_level" >"$STATE_FILE"
          setsid bash -c 'sleep 300; ${config.xdg.configHome}/gh/gh-contrib.sh' >/dev/null 2>&1 &
        fi
        ;;
      esac
    '';
  };
}
