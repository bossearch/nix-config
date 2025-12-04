{config, ...}: {
  home.file.".config/waybar/scripts/temp/graph.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      case "$1" in
      cpu) TEMP_FILE="$HOME/.cache/${config.spec.userName}/cputemp" ;;
      gpu) TEMP_FILE="$HOME/.cache/${config.spec.userName}/gputemp" ;;
      *) exit 1 ;;
      esac

      POINTS=36 ROWS=11
      EMPTY="⠀" S1="⣀" S2="⣤" S3="⣶" S4="⣿" BLANK="⣀"
      RED="#${config.colorScheme.palette.base08}"
      YELLOW="#${config.colorScheme.palette.base0A}"
      GREEN="#${config.colorScheme.palette.base0B}"
      GRAY="#${config.colorScheme.palette.base04}"

      # Hex to RGB conversion
      hex_to_rgb() {
        local h="''${1#"#"}"
        printf "%d %d %d\n" "0x''${h:0:2}" "0x''${h:2:2}" "0x''${h:4:2}"
      }

      # Precompute all row colors once
      declare -A ROW_COLORS
      read -r "R[0]" "G[0]" "B[0]" <<<"$(hex_to_rgb "$RED")"
      read -r "R[1]" "G[1]" "B[1]" <<<"$(hex_to_rgb "$YELLOW")"
      read -r "R[2]" "G[2]" "B[2]" <<<"$(hex_to_rgb "$GREEN")"

      for ((row = 1; row <= ROWS; ++row)); do
        pos=$((row - 1))
        if ((pos > 5)); then
          idx=0
          frac=$(((11 - row) * 100 / 6))
        else
          idx=1
          frac=$(((5 - pos) * 100 / 6))
        fi
        [[ $frac -gt 100 ]] && frac=100
        [[ $frac -lt 0 ]] && frac=0

        r=$((R[idx] + (R[idx + 1] - R[idx]) * frac / 100))
        g=$((G[idx] + (G[idx + 1] - G[idx]) * frac / 100))
        b=$((B[idx] + (B[idx + 1] - B[idx]) * frac / 100))

        ROW_COLORS[$row]=$(printf "#%02X%02X%02X" "$r" "$g" "$b")
      done

      # Load values with padding
      mapfile -t vals < <(tail -n $POINTS "$TEMP_FILE" 2>/dev/null)
      while ((''${#vals[@]} < POINTS)); do vals=(0 "''${vals[@]}"); done

      # Pre-process values once (remove whitespace, convert to int)
      for ((i = 0; i < ''${#vals[@]}; ++i)); do
        vals[i]=$((''${vals[i]//[[:space:]]/} / 1))
      done

      # Build graph
      graph=""
      for ((row = ROWS; row >= 1; --row)); do
        line=""
        for val in "''${vals[@]}"; do
          if ((val == 0)); then
            if ((row == 1)); then
              line+="$BLANK"
            else
              line+="$EMPTY"
            fi
          else
            height_scaled=$((val * 100 / 10))
            full_rows=$((height_scaled / 100))
            frac_scaled=$((height_scaled % 100))

            if ((row <= full_rows)); then
              line+="$S4"
            elif ((row == full_rows + 1)); then
              # Inline partial symbol logic
              if ((frac_scaled <= 0)); then
                line+="$EMPTY"
              elif ((frac_scaled <= 25)); then
                line+="$S1"
              elif ((frac_scaled <= 50)); then
                line+="$S2"
              elif ((frac_scaled <= 75)); then
                line+="$S3"
              else
                line+="$S4"
              fi
            else
              line+="$EMPTY"
            fi
          fi
        done

        color="''${ROW_COLORS[$row]}"

        case $row in
        11) label="100°C" ;;
        9) label=" 80°C" ;;
        7) label=" 60°C" ;;
        5) label=" 40°C" ;;
        3) label=" 20°C" ;;
        1) label="  0°C" ;;
        *) label="     " ;;
        esac

        # Row 1 special handling
        if ((row == 1)); then
          blanks="" fills="" blank_done=0
          for ((i = 0; i < ''${#line}; ++i)); do
            char="''${line:$i:1}"
            if [[ "$char" == "$BLANK" ]] && ((blank_done == 0)); then
              blanks+="$char"
            else
              blank_done=1
              fills+="$char"
            fi
          done
          row_line=""
          [[ -n $blanks ]] && row_line+="<span foreground=\\\"$GRAY\\\">$blanks</span>"
          [[ -n $fills ]] && row_line+="<span foreground=\\\"$color\\\">$fills</span>"
        else
          row_line="<span foreground=\\\"$color\\\">$line</span>"
        fi

        graph+="$label│$row_line\n"
      done

      # Build x-axis
      half=$((POINTS / 2 - 4))
      x_axis="     ├"
      for ((j = 0; j < half; ++j)); do x_axis+="─"; done
      x_axis+=" 3 mins "
      for ((j = 0; j < half; ++j)); do x_axis+="─"; done
      x_axis+="┤"

      graph+="$x_axis"

      echo "$graph"
    '';
  };
}
