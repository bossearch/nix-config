{
  home.file.".config/fzf/extra/pass.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      key="$1"
      prefix=$(senior print-dir)
      password_files=$(
        find -L "$prefix" \( -name '.*' \) -prune -o -type f -print 2>/dev/null |
          sed -e "s#''${prefix}/\{0,1\}"'##' -e 's#\.age##' -e 's#\\#\\\\#g' -e 's#:#\\:#g' |
          sort
      )

      menu="fzf --layout=default --border=none"
      win=$(jq -r '.address' /tmp/prev_window)

      if [[ $key = "otp" ]]; then
        password=$(printf '%s\n' "$password_files" | $menu)
      else
        password=$(printf '%s\ngenerate\n' "$password_files" | $menu) # generate menu on top
        # password=$(printf 'generate\n%s\n' "$password_files" | $menu) # generate menu on bottom
      fi

      if [[ -n "$password" ]]; then
        if [[ "$password" == "generate" ]]; then
          charset="abcdefghijklmnopqrstuvwxyz"

          while true; do
            read -r -p $'\e[32m❯\e[0m Password length (16–64): ' length
            length=''${caps:-16}
            if ! [[ "$length" =~ ^[0-9]+$ ]]; then
              echo "Must be a number."
              continue
            fi
            if ((length < 16 || length > 64)); then
              echo "Length must be between 16 and 64."
              continue
            fi
            break
          done

          read -r -p $'\e[32m❯\e[0m Include capital letters? (y/n): ' caps
          caps=''${caps:-y}
          caps=''${caps,,}
          read -r -p $'\e[32m❯\e[0m Include numbers? (y/n): ' nums
          nums=''${nums:-y}
          nums=''${nums,,}
          read -r -p $'\e[32m❯\e[0m Include special characters? (y/n): ' special
          special=''${special:-y}
          special=''${special,,}

          if [[ "$caps" == "y" ]]; then
            charset+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
          fi

          if [[ "$nums" == "y" ]]; then
            charset+="0123456789"
          fi

          if [[ "$special" == "y" ]]; then
            charset+="!@#$%^&*()_+-={}[]:;,.?"
          fi

          password_gen=$(tr -dc "$charset" </dev/urandom | head -c "$length")

          wl-copy "$password_gen" >/dev/null 2>&1

          hyprctl dispatch focuswindow address:"$win" >/dev/null 2>&1

          tmpfile=$(mktemp)

          printf "%s" "$password_gen" >"$tmpfile"

          setsid --fork bash -c "
            sleep 0.2
            ydotool type --file \"$tmpfile\"
            rm -f \"$tmpfile\"
          " >/dev/null 2>&1 &
          disown
        else
          if [[ ! $key = "otp" ]]; then
            while true; do
              echo -e "Choose an option:"
              echo "1. Username and password"
              echo "2. Username only"
              echo "3. Password only"
              read -r -p $'\e[32m❯\e[0m Select an option (1-3): ' option

              if [[ "$option" =~ ^[1-3]$ ]]; then
                break
              else
                echo -e "\e[31mInvalid option. Please choose a valid option (1-3).\e[0m"
              fi
            done

            case $option in
            1) key=("email" "password") ;;
            2) key=("email") ;;
            3) key=("password") ;;
            *) notify-send -u critical "Unexpected error" ;;
            esac
          else
            key=("otp")
          fi
          hyprctl dispatch focuswindow address:"$win" >/dev/null 2>&1
          setsid --fork bash -c '
            password="$1"
            shift
            keys=("$@")

            sleep 0.2  # Allow time for window focus

            for k in "''${keys[@]}"; do
              tmpfile=$(mktemp)

              value=$(senior show --key "$k" "$password")

              printf "%s" "$value" >"$tmpfile"

              ydotool type --file "$tmpfile"
              rm -f "$tmpfile"

              case "$k" in
                email) ydotool key 15:1 15:0 ;;   # Tab
                password|otp) ydotool key 28:1 28:0 ;; # Enter
              esac
              sleep 0.2
            done
          ' _ "$password" "''${key[@]}" >/dev/null 2>&1 &
          disown
        fi
      else
        exit
      fi
    '';
  };
}
